class Api::V1::EventsController < Api::V1::BaseController

	def index
		@events = policy_scope(Event.all.preload(:users))
		.where(query_params)
		.page(page_params[:page])
		.per(page_params[:page_size])
	end

	def ics_export 
    @meetings = Event.all
    respond_to do |format|
      format.html
      format.ics do
        cal = Icalendar::Calendar.new
        @meetings.each do |meet|
          calevent = Icalendar::Event.new
          calevent.dtstart = meet.happening
          calevent.summary = meet.title.titleize
          cal.add_event(calevent)
        end
        cal.publish
        render :text =>  cal.to_ical 
      end
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :description, :happening, :project_id, user_ids:[], users_attributes:[:id])
    end

		def query_params
			{project_id: params[:project_id]}
		end
end
