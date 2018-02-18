class CreateLikeOp < Backend::Op
  field :content_id,
        :content_type

  validates :content_id,
            :content_type, presence: true

  attr_reader :content

  protected

  def perform
      like = build_like
      like.save!
      @content = like.content

    true
  end

  def build_like
    Like.new.tap do |l|
      l.user         = current_user
      l.content_id   = content_id
      l.content_type = content_type
    end
  end
end
