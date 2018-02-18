class UpdateEventOp < Backend::Op
  include Mixins::EventManagementOp

  field :id

  validates :id, presence: true

  attr_accessor :updated_event

  protected
  
  def perform
    event = Event.find id
    patch_attributes(event)

    event.save!

    event.reload
    @updated_event = event

    true
  end
end
