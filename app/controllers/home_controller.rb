class HomeController < ApplicationController
  
  def index
    if user_signed_in?
      redirect_to projects_path
    end
  end

  def education
  end

  def business
  end

  def about

    #@render =  :partial => render_to_string(:partial => "partial/path", :object => @object) }
    #logger.fatal render_to_string( partial: 'api/v1/users/user.json.jbuilder', :locals => {:user => current_user})
    # render :json => { 
    #   :success => true,
    #   :data => render_to_string( template: 'api/v1/users/show.json.jbuilder', :locals => {:user => current_user}) 
    # }
  end

	def search
	  if params[:q].nil?
	    @messages = []
	  else
	    @messages = Message.search params[:q]
	  end
	end

  def jobs
  end

  def team
  end

  def terms
  end 

  # To be move later
  def export_pdf
    note = Note.find(params[:note_id])
    filename = "#{note.title.parameterize}.pdf"
    kit = PDFKit.new(note.content, :page_size => 'Letter')
    send_data(kit.to_pdf,:filename => filename, :type => "application/pdf")
  end

  def scotedge
    redirect_to "https://youtu.be/zLJEejp48Jo"
  end

  def cookiespolicy
  end

  def prenium
    session[:http_referer] = "abuni"
    redirect_to new_user_registration_path
  end

end
