class Meetup < ApplicationRecord
  # belongs_to :recipe
  # belongs_to :host, class_name: "Request"
  # belongs_to :guest, class_name: "Request"
  has_many :reviews
end
