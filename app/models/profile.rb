class Profile < ActiveRecord::Base

belongs_to :user, dependent: :destroy

mount_uploader :image, ImageUploader
# mount_uploader :banner, ImageUploader

def username
  	self.user.name
end

extend FriendlyId
  friendly_id :username, use: :slugged

end
