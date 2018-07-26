class User < ApplicationRecord
  has_many :tickets
  has_many :events, through: :tickets
  has_many :owned_events, foreign_key: "user_id", class_name: "Event"
# dependent destory allows you to call User.destroy and delete all chat rooms own by user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  def name
    email.split('@')[0]
  end
end
