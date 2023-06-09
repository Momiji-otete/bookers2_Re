class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :view_counts, dependent: :destroy

  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : "no_image.jpg"
  end

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_for(method, search_word)
    if method == "perfect"
      User.where(name: search_word)
    elsif method == "forward"
      User.where('name LIKE ?', search_word + '%')
    elsif method == "backward"
      User.where('name LIKE ?', '%' + search_word)
    else
      User.where('name LIKE ?', '%' + search_word + '%')
    end
  end

end
