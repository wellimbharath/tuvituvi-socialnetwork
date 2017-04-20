class Post < ActiveRecord::Base

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user}

  belongs_to :user
  has_many :replies, dependent: :destroy

  has_many :comments, dependent: :destroy
  
  scope :post, -> (current_user) {where user_id: current_user}
  
  scope :followings, ->(follows) { where user_id: follows }
  
  has_attached_file :audio
  validates_attachment_content_type :audio, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio']
  
  has_attached_file :video
  validates_attachment_content_type :video, :content_type => [ 'video/mpeg', 'video/x-mpeg', 'video/mp4', 'video/x-mp4', 'video/x-mpeg4', 'video/wmv', 'video/flv', 'video']
  
  has_attached_file :image, styles: { post: "800x400*" ,  medium: "500x500#", small: "300x300#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  validates_presence_of :user
  
  default_scope -> { order('created_at DESC') }
  
  acts_as_votable

  # auto_html_for :content do 
  #   html_escape
  #   image( class: 'ui fluid image')
  #   youtube( autoplay: false, class: 'ui fluid image')
  #   link :target => "_blank", :rel => "nofollow"
  #   simple_format
  # end

  def self.from_users_followed_by(user)
  followed_user_ids = user.followed_user_ids
    where("user_id IN (:followed_user_ids) OR user_id = :user_id", followed_user_ids: followed_user_ids, user_id: user)
  end


end
