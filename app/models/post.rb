class Post < ApplicationRecord

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :notifications, as: :notifiable, dependent: :destroy

  has_one_attached :post_image

  validates :title, length: { minimum: 2, maximum: 50 }, presence: { message: 'を入力してください' }
  validates :content, length: { maximum: 300 }, presence: { message: 'を入力してください' }
  validates :post_image, presence: { message: 'を選択してください' }, blob: { content_type: :image }

  def get_post_image
    (post_image.attached?) ? post_image : 'no_image.jpg'
  end

  def self.ransackable_attributes(auth_object = nil)
    auth_object ? super : %w(title content)
  end

  def self.ransackable_associations(auth_object = nil)
    auth_object ? super : []
  end

  def favorited_by?(user)
   favorites.exists?(user_id: user.id)
  end

  def save_tags(savepost_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name:new_name)
      self.tags << post_tag
    end
  end

  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end
end
