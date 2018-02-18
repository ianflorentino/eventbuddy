module V1
  class Base < ApplicationAPI
    version 'v1', using: :path
    mount UserAPI
    mount EventAPI
    mount CommentAPI 
    mount LikeAPI
  end
end
