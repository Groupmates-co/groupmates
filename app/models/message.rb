require 'elasticsearch/model'

class Message < ActiveRecord::Base

	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  belongs_to :channel

  has_one :msg_view
	has_and_belongs_to_many :assets, class_name: "Asset"
	accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true

	validates :content, presence: true, length: { minimum: 1 }
	validates :user, presence: true
	validates :channel, presence: true

	auto_html_for :content do
		html_escape
    vimeo
    dailymotion
    youtube(:width => 400, :height => 225, :autoplay => false)
    lolcats
    flickr
    gist
    google_map
    # instagram
    # liveleak
    # redcarpet
    # metacafe
    # soundcloud
    ted
    twitter
    image
    emojis
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

	def assets_ids=(assets_ids)    
		self.assets = Asset.find(assets_ids)
  end

  def set_welcome_message(channel)
  	self.channel = channel
  	self.user = User.find_by(admin: 2)
  	self.content = "We welcome you to your new project. Get a whole new experience of collaborative working using Groupmates ;)"
  	self.save
  end

  def set_help_message(channel)
  	self.channel = channel
  	self.user = User.find_by(admin: 2)
  	self.content = "Invite your groupmates in the Settings section."
  	self.save
  end

	# settings index: { number_of_shards: 1 } do
	#   mappings dynamic: 'false' do
	#     indexes :content, analyzer: 'english', index_options: 'offsets'
	#   end
	# end

	def self.search(query)
	  __elasticsearch__.search(
	    {
	      query: {
	        multi_match: {
	          query: query,
	          fields: ['content', 'text']
	        }
	      },
				highlight: {
	        pre_tags: ['<em>'],
	        post_tags: ['</em>'],
	        fields: {
	          content: {}
	        }
      	}
	    }
	  )
	end

  def as_indexed_json(options={})
    as_json(
      only: [:id, :content, :created_at],
      include: { user: { only: [:id, :first_name, :last_name, :email] }}
    )
  end

end

# Delete the previous messages index in Elasticsearch
Message.__elasticsearch__.client.indices.delete index: Message.index_name rescue nil
 
# Create the new index with the new mapping
Message.__elasticsearch__.client.indices.create \
  index: Message.index_name,
  body: { settings: Message.settings.to_hash, mappings: Message.mappings.to_hash }
 
# Index all Message records from the DB to Elasticsearch
Message.import