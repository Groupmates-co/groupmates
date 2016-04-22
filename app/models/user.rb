class User < ActiveRecord::Base
  include Gravtastic

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  DEFAULT_PROFILE_PICTURE = "https://s3-eu-west-1.amazonaws.com/groupmates/user_placeholder.png"

	TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  gravtastic
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable


  attr_accessor :profile_picture

  before_save :ensure_authentication_token!

  has_many :channels
  has_many :assignations
  has_many :projects, through: :assignations
  has_many :msg_views
  has_and_belongs_to_many :events
  has_many :assets
  has_many :messages
  has_many :folders
  has_one :last_project, class_name: "Project", foreign_key: "last_project_quit"
  has_many :preferences

  has_attached_file :profile_picture,
    :styles => {
      :small => "100x100#",
      :thumb => "250x250#"
    },
    :default_style => :thumb,
    :url => "/uploads/:class/:id/:style_:filename",
    :path => ":rails_root/public/uploads/:class/:id/:style_:filename",
    :default_url => DEFAULT_PROFILE_PICTURE,
    :convert_options => { :all => '-strip -trim' }

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/

  # Oauth signup method
	def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?

      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email || auth.extra.raw_info.email_verified)
      email = auth.info.email if email_is_verified || auth.raw_info.email if auth.extra.raw_info.email_verified
      user = User.where(:email => email).first if email

      if user.nil?

        case auth.provider
          when "google_oauth2"
            picture = UserFs::save_user_picture(auth.info.image)
          when "facebook"
            picture = UserFs::save_user_picture("https://graph.facebook.com/#{auth.uid}/picture?type=large")
          else
            picture = nil
        end

        user = User.new(
          first_name: auth.info.first_name || auth.raw_info.given_name,
          last_name: auth.info.last_name || auth.extra.raw_info.family_name,
          profile_picture: open(picture),
          email: email ? email : auth.info.email,
          password: Devise.friendly_token[0,20],
          is_oauth: true
        )
        user.skip_confirmation!
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def fullname
    "#{self.first_name} #{self.last_name}"
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def skip_confirmation!
    self.confirmed_at = Time.now
  end

  def ensure_authentication_token!
    if authentication_token.blank?
      #Disable email confirmation
      self.skip_confirmation!
      #Ensure user has a token for API Auth
      self.authentication_token = Devise.friendly_token
    end
  end

  def reset_authentication_token
    self.authentication_token = Devise.friendly_token
    self.save
  end

  def as_indexed_json(options={})
    as_json(
      only: [:id, :first_name, :last_name, :email]
    )
  end

  def get_unread_messages(project_id)
    Message.find_by_sql(["SELECT * FROM messages m INNER JOIN channels c ON m.channel_id = c.id INNER JOIN channels_users cu ON c.id = cu.channel_id INNER JOIN users u ON cu.user_id = u.id WHERE u.id = ? AND u.last_project_quit < m.created_at AND u.current_sign_in_at < m.created_at AND c.project_id = ?", self.id, project_id]).count
  end
end
