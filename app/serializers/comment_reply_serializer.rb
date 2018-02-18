class CommentReplySerializer < ActiveModel::Serializer
  attributes :id, 
             :body, 
             :user_full_name,
             :created_at,
             :like_count,
             :replies
  
  has_many :replies, serializer: CommentSerializer

  def user_full_name
    "#{object.user.first_name} #{object.user.last_name}"
  end
end
