module Mixins
  module EventManagementOp
    extend ::ActiveSupport::Concern

    included do
      fields :title,
             :description,
             :location,
             :start_date,
             :end_date,
             :main_image_content_type,
             :main_image_file_name,
             :main_image_file_size


    end
  end
end
