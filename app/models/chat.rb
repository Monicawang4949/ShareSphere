class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :notification, as: :notifiable, dependent: :destroy
  validates :message, presence: true, length: { maximum: 140 }

  after_create do
    notification_user_id = UserRoom.where(room_id: room.id).where.not(user_id: current_user.id).user_id
    create_notification(user_id: notification_user_id, notifiable_type: “Chat”)
  end
end
