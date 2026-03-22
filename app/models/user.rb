class User < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :events, through: :tickets
  has_many :owned_events, foreign_key: "user_id", class_name: "Event"
  has_many :comments, dependent: :destroy

  geocoded_by :location
  after_validation :geocode

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
  has_many :personal_messages, dependent: :destroy

  has_one_attached :avatar
  validate :acceptable_avatar

  scope :activity_goal, ->(activity_goal) { where(activity_goal: activity_goal) }
  scope :fitness_level, ->(fitness_level) { where(fitness_level: fitness_level) }
  scope :gender, ->(gender) { where(gender: gender) }

  def name
    email.split('@')[0]
  end

  def online?
    Redis.new.get("user_#{id}_online").present?
  end

  def full_name
    "#{first_name} #{last_name}" if first_name && last_name
  end

  private

  def acceptable_avatar
    return unless avatar.attached?

    if avatar.blob.byte_size > 5.megabytes
      errors.add(:avatar, "is too large (max 5MB)")
    end

    acceptable_types = %w[image/jpeg image/png image/gif image/webp]
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, "must be a JPEG, PNG, GIF, or WebP image")
    end
  end
end
