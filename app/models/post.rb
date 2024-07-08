class Post < ApplicationRecord

  belongs_to :user

  has_one_attached :post_image

  validates :title, length: { minimum: 2, maximum: 50 }
  validates :content, length: { maximum: 300 }

  def get_post_image
    (post_image.attached?) ? post_image : 'no_image.jpg'
  end

  def self.ransackable_attributes(auth_object = nil)
    auth_object ? super : %w(title content)
  end

  def self.ransackable_associations(auth_object = nil)
    auth_object ? super : []
  end
end
