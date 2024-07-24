class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :notification, as: :notifiable, dependent: :destroy
  validates :message, presence: true, length: { maximum: 140 }

  after_create do
    create_notification(user_id: chat.user_id)
  end
end
