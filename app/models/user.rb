class User < ApplicationRecord
  has_many :tickets
  has_many :events, through: :tickets
  has_many :owned_events, foreign_key: "user_id", class_name: "Event"

  has_many :comment

  geocoded_by :location
  after_validation :geocode


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
  has_many :personal_messages, dependent: :destroy
  # active_storage module for giving users avatar photos
  has_one_attached :avatar

  def name
    email.split('@')[0]
  end

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end

  def full_name
    if first_name && last_name
      "#{first_name} #{last_name}"
    end
  end
end
