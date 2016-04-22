class Api::V1::TasksController < Api::V1::BaseController

  def index
    render :text => '{
  "success":true,
  "info":"ok",
  "data":{
          "tasks":[
                    {"title":"Complete the app"},
                    {"title":"Complete the tutorial"}
                  ]
         }
}'
  end
end

# DUMMY Data alert
# THIS CLASS IS USED FOR TEST PURPOSE, THIS CODE IS NOT PART OF THE APP