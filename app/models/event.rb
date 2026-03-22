class Event < ApplicationRecord
  belongs_to :owner, foreign_key: 'user_id', class_name: 'User'
  has_many :tickets, dependent: :destroy
  has_many :users, through: :tickets
  has_many :comments, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :title, :address, :time, :description, :activity_type, presence: true
end
