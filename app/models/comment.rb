class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :replies, as: :commentable, foreign_key: 'commentable_id', class_name: 'Comment', dependent: :destroy

  include Likable

  SOURCE_TYPES = %w(Comment Event)
end
