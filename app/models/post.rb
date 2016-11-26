class Post < ActiveRecord::Base

belongs_to :user

mount_uploader :image, ImageUploader
mount_uploader :audio, AudioUploader

acts_as_taggable

extend FriendlyId
  friendly_id :title, use: :slugged

 validates_presence_of :title
  validates_presence_of :audio

 validates :title, :uniqueness => {:scope => :user_id}

 has_many :user_favs
has_many :favourited_by, through: :user_favs, :source => :user
has_many :favourites, through: :user_favs, :source => :user

paginates_per 6


end
