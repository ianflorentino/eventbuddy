class CreateEventOp < Backend::Op
  include Mixins::EventManagementOp

  attr_accessor :event

  protected
  
  def perform
    event = build_event
    event.save!

    event.reload
    @event = event

    add_admin

    true
  end

  def build_event
    Event.new.tap do |e|
      e.title                   = title
      e.description             = description
      e.location                = location
      e.start_date              = start_date
      e.end_date                = end_date
      e.main_image_content_type = main_image_content_type
      e.main_image_file_name    = main_image_file_name
      e.main_image_file_size    = main_image_file_size
    end
  end

  def add_admin
    @event.make_users_admin([current_user.id])
  end
end
