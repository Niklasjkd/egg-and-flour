class Review < ApplicationRecord
  belongs_to :meetup
  belongs_to :user
  validates :content, presence: true
  validates :rating, presence: true
end
