class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable,
         :authentication_keys => [:login]

  acts_as_voter

  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :replies, dependent: :destroy

  has_many :followings

  has_many :follows, :through => :followings

  has_many :inverse_followings, :class_name => "Following", :foreign_key => "follow_id"

  has_many :inverse_follows, :through => :inverse_followings, :source => :user

  has_many :comments, dependent: :destroy

  has_many :groups

  has_many :dreams
  validates :username, :presence => true, :uniqueness => {:case_sensitive => false}

  has_attached_file :avatar, :styles => { :large => "800x800>", :medium => "500x500#" , :thumb=> "200x200#", :small => "100x100#"}, :default_url => "/missing.png",:processors => [:cropper],  :dependent => :destroy

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping?

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end

 def fullname
  firstname + " " + lastname
 end

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_attached_file :background, :default_url => "images/404.jpg"

  has_many :user_networks

  has_many :friends, through: :user_networks

  has_many :blockd, -> {where(user_networks: {state: 'blocked'})}, through: :user_networks

  has_many :pending_user_networks, -> {where state: 'pending'}, class_name: 'UserNetwork',
  foreign_key: :user_id

  has_many :pending_friends, through: :pending_user_networks, source: :friend

  has_many :requested_user_networks, -> {where state: 'requested'}, class_name: 'UserNetwork', foreign_key: :user_id

  has_many :requested_friends, through: :requested_user_networks, source: :friend

  has_many :accepted_user_networks, -> {where state: 'accepted'}, class_name: 'UserNetwork', foreign_key: :user_id

  has_many :accepted_friends, through: :accepted_user_networks, source: :friend

  has_many :blocked_user_networks, -> {where state: 'blocked'}, class_name: 'UserNetwork', foreign_key: :user_id

  has_many :blocked_friends, through: :blocked_user_networks, source: :friend

  after_update :reprocess_avatar, :if => :cropping?

  attr_accessor :login




  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  # Mysql users should use this !important

  def self.find_for_database_authentication(warden_conditions)

      conditions = warden_conditions.dup

      if login = conditions.delete(:login)

        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first

      else

        where(conditions.to_h).first

      end

  end

    private

  def reprocess_avatar
    avatar.reprocess!
  end
end
