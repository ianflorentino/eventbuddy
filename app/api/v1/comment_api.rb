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
        comment            = Comment.find_by(id: params[:id])
        source             = comment.commentable
        same_user_or_admin = (comment.user_id == current_user.id) || (source.admins.include?(current_user))

        return error!("Comment not found or already deleted", 404) unless comment.present?
        return error!("Not authorized to delete", 401) unless same_user_or_admin

        comment.destroy
        { deleted_comment: params[:id] }
      end
    end
  end
end
