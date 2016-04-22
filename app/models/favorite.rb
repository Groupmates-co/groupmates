class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  belongs_to :project
end
