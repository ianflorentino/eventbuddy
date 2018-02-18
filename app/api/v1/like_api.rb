module V1
  class LikeAPI < Base
    resource :likes do
      desc 'create a like on a content'
      params do
        requires 'content_id', type: Integer
        requires 'content_type', type: String, values: Like::CONTENT_TYPES
      end
      post do
        op = CreateLikeOp.new(current_user, params)
        op.submit

        return return_error(op, 400) unless op.errors.blank?
        op.content
      end

      desc 'unlink a content'
      params do
        requires 'content_id', type: Integer
        requires 'content_type', type: String, values: Like::CONTENT_TYPES
      end
      delete '' do
        like = Like.includes(:content).find_by(
          user_id: current_user.id,
          content_id: params[:content_id],
          content_type: params[:content_type]
        )
        return return_error("Like not found or already deleted", 404) unless like.present?

        content = like.content
        like.destroy
        content = content.reload

        { unliked_content: UnlikedContentSerializer.new(content) }
      end
    end
  end
end
