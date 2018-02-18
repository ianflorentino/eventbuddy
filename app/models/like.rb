class Like < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true

  validates_presence_of :content, :user
  validates_uniqueness_of :content_id, scope: [:user_id, :content_type]

  CONTENT_TYPES = %w(Comment)
end
