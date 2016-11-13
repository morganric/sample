class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  after_create :create_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_one :profile

  has_many :user_favs
  has_many :favourites, through: :user_favs, :source => :post

  validates_uniqueness_of :name

  codes = []

  User.all.each do |user|
    codes << user.name
  end
  
  codes = codes.concat ["rekkerd", "mixsampleapp", "learnproducing", "grillobeats"]

  validates :code, inclusion: codes

  def create_profile
    @profile = Profile.new(:user_id => id)
    @profile.display_name = self.name
    @profile.save
  end


end


