class Subscription < ActiveRecord::Base

  has_many :referrals, :class_name => "Subscription", :foreign_key => "referrer_id"
  belongs_to :referrer, :class_name => "Subscription", :foreign_key => "referrer_id"

 	before_create :create_referral_code

	validates :email, presence: true, uniqueness: true, length: { minimum: 5 }
	validates_format_of :email, :with => /@/
	validates :referral_code, :uniqueness => true

	private
		def create_referral_code
	    referral_code = SecureRandom.hex(5)
	    @collision = Subscription.find_by(referral_code: referral_code)

	    while !@collision.nil?
	      referral_code = SecureRandom.hex(5)
	      @collision = Subscription.find_by(referral_code: referral_code)
	    end

	    self.referral_code = referral_code
  	end
end
