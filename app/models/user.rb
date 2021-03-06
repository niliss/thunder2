class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :likes

  # A random user I haven't like or unlike yet
  def random_friend
    restricted_ids = self.likes.pluck(:friend_id) << self.id
    User.where.not(id: restricted_ids).order("RANDOM()").first
  end

  def liked?(user)
    likes.find_by_friend_id(user.id)
  end
end
