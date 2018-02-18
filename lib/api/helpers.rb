module API
  module Helpers
    extend self

    def serialize_response(resource)
      resource.errors.blank? ? resource : serialize_error(resource)
    end

    def serialize_error(resource)
      message = resource.errors.messages.first.first.to_s.humanize + ' ' + resource.errors.messages.first.second.to_sentence
      {
        error: {
          error_code: status,
          error_message: message
        }
      }
    end
  end
end
