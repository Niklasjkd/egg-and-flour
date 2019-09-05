class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_ingredients
  has_many :requests
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :reviews

  def average_rating
    reviews = Review.where(for_user_id: id)
    all_ratings = reviews.map { |review| review.rating }
    (all_ratings.reduce(:+).to_f / all_ratings.size) if all_ratings.any?
  end
end
