module V1
  class CommentAPI < Base
    resource :comments do
      desc 'create a comment on a source type'
      params do
        requires 'body', type: String
        requires 'source_id', type: Integer
        requires 'source_type', type: String, values: Comment::SOURCE_TYPES
      end
      post do
        op = CreateCommentOp.new(current_user, params)
        op.submit

        return_error(op, 400) unless op.errors.blank?
        op.comment
      end

      desc 'view a comment & replies'
      get ':id', serializer: CommentReplySerializer do
        comment = Comment.find_by(id: params[:id])

        error!("Comment missing",  404) unless comment.present?
        comment
      end

      desc 'delete a comment'
      delete ':id' do
        comment = Comment.find_by(id: params[:id])
        return error!("Comment not found or already deleted", 404) unless comment.present?

        comment.destroy
        { deleted_comment: params[:id] }
      end
    end
  end
end
