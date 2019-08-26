class Request < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  has_many :meetups_as_host, source: :meetups, foreign_key: :host_id
  has_many :meetups_as_guest, source: :meetups, foreign_key: :guest_id
end
