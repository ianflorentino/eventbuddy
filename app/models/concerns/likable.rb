module Likable
  extend ActiveSupport::Concern
  included do
    has_many :likes, as: :content
    has_many :likers, through: :likes, source: :user
  end

  def like_count
    likes.count
  end

  def liked_by_user?(user_id)
    Like.where(content: self, user_id: user_id).present?
  end
end
