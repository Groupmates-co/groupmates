# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# unless Rails.env.production?
#
#   # Insert Groupmates bot
#   bot = User.create!({
#     first_name: "Groupmates",
#     last_name: "Assistant",
#     password: Devise.friendly_token,
#     profile_picture: open(Rails.root.join('app','assets','images','groupmates_bot.jpg')),
#     #open(ActionController::Base.helpers.asset_url('groupmates_bot.jpg')),
#     email: "support@groupmates.uk",
#     admin: 2,
#     is_oauth: 0
#   })
#
#   # Re-index Elasticsearch
#   User.import
#   Message.import
# end

#if Rails.env.development?

	#Connect db
  connection = ActiveRecord::Base.connection

  #Disable foreign key check
  connection.execute("SET FOREIGN_KEY_CHECKS = 0;")

  #Truncate all tables
  connection.tables.each do |table|
   connection.execute("TRUNCATE #{table}") unless table == "schema_migrations"
  end

  #re-Enable foreign key check
  connection.execute("SET FOREIGN_KEY_CHECKS = 1;")

  # Insert Groupmates bot
  bot = User.create!({
    first_name: "Groupmates",
    last_name: "Assistant",
    password: Devise.friendly_token,
    profile_picture: open(Rails.root.join('app','assets','images','groupmates_bot.jpg')),
    #open(ActionController::Base.helpers.asset_url('groupmates_bot.jpg')),
    email: "support@groupmates.co",
    admin: 2,
    is_oauth: 0
  })

	# Import Data fixtures
  sql = File.read(Rails.root.join('db','demo_data-04-22-16.sql'))
  statements = sql.split(/;$/)
  statements.pop

 	# Execute queries
  ActiveRecord::Base.transaction do
    statements.each do |statement|
      connection.execute(statement)
    end
  end

  # Re-index Elasticsearch
  #User.import
  #Message.import
#end
