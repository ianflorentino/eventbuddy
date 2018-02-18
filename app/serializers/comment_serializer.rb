class CommentSerializer < ActiveModel::Serializer
  attributes :id, 
             :body, 
             :user_full_name,
             :created_at,
             :replies_count,
             :like_count

  def user_full_name
    "#{object.user.first_name} #{object.user.last_name}"
  end

  def replies_count
    object.replies.count
  end
end
