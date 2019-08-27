class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_ingredients
  has_many :requests
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :image, presence: true
  # validates :lng, presence: true
  # validates :lat, presence: true
end
