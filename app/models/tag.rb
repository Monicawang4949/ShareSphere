class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags

  def self.ransackable_attributes(auth_object = nil)
    auth_object ? super : %w(name)
  end

  def self.ransackable_associations(auth_object = nil)
    auth_object ? super : []
  end
end
