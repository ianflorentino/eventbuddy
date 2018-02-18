class CreateCommentOp < Backend::Op

  fields :body,
         :source_id,
         :source_type

  validates :source_id,
            :source_type, 
            :body, presence: true

  attr_accessor :comment

  protected
  
  def perform
    @source = source_type.constantize.find(source_id)
    comment = build_comment
    comment.save!

    comment.reload
    @comment = comment

    true
  end

  def build_comment
    Comment.new.tap do |e|
      e.user = current_user
      e.body = body
      e.commentable = @source
    end
  end
end
