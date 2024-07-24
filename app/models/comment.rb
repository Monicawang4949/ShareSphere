class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :content, presence: true

  after_create do
    create_notification(user_id: post.user_id)
  end
end
