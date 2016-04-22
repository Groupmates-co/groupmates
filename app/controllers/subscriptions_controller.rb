class SubscriptionsController < ApplicationController
  
  def subscribe

  	@subscription = Subscription.new(subscription_params)
  	@referred_by = Subscription.find_by(referral_code: cookies[:h_ref])

		cur_ip = IpAddress.find_by(address: request.remote_ip)
    if !cur_ip
			cur_ip = IpAddress.create(
				:address => request.remote_ip,
				:count => 0
			)
    end

    if !Subscription.find_by(email: @subscription.email)
			if cur_ip.count > 2
				#Add a notice
				return redirect_to root_path
			else
				cur_ip.count = cur_ip.count + 1
				cur_ip.save
			end

			if !@referred_by.nil?
      	@subscription.referrer = @referred_by
    	end
    
   		@subscription.save
   	end
    
    if !@subscription.nil?
    	cookies[:h_email] = { :value => @subscription.email }
    end

		redirect_to action: :referral
			#render json: "error", status: 500 
			# Need to change that
			#render :status => 422, :json => { :errors => @subscription.errors.full_messages }
  end

  def referral
  	@subscription = Subscription.find_by(email: cookies[:h_email])
  	if @subscription
			@uniquelink = refer_url(@subscription.referral_code)
			@progress = get_progress(@subscription.referrals.count)
			@referrees = @subscription.referrals.count
		else
			redirect_to root_path
		end
  end

  def refer
  	redirect_to root_path
  end

	private
		# Allowed params for project
		def subscription_params
			params.require(:subscription).permit(:email)
		end

		def get_progress(referrals)
			x = referrals
			progress = 0

			if x == 0 
				progress = 1;
			elsif x > 0 and x < 5
				progress = x*8+1;
			elsif x == 5
				progress = 42;
			elsif x > 5 and x < 8
				progress = 42+((x-5)*4)
			elsif x >= 8 and x<11 
				progress = 50+((x-7)*3)
			elsif x >= 11 
				progress = 59+(1*(x-10)+1)
			elsif x >= 47
				progress = 97
			else
				progress = 100 
			end

			return progress
		end


end