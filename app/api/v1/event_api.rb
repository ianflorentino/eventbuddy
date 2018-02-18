module V1
  class EventAPI < Base
    resource :events do
      get ':id', skip_authorization: true do
        event = Event.find_by(id: params[:id])

        error!("Event missing",  404) unless event.present?
        event
      end

      desc 'create an event'
      params do
        requires 'title', type: String, allow_blank: false
        optional 'description', type: String
        optional 'location', type: String
        optional 'start_date', type: DateTime
        optional 'end_date', type: DateTime
      end
      post '', skip_authorization: true do
        op = CreateEventOp.new(current_user, params)
        op.submit

        return_error(op, 400) unless op.errors.blank?
        op.event
      end

      desc 'update an event'
      params do
        optional 'title', type: String, allow_blank: false
        optional 'description', type: String
        optional 'location', type: String
        optional 'start_date', type: DateTime
        optional 'end_date', type: DateTime
      end
      put ':id', skip_authorization: true do
        op = UpdateEventOp.new(current_user, params)
        op.submit

        return_error(op, 400) unless op.errors.blank?
        op.updated_event
      end

      desc 'delete an event'
      delete ':id' do
        event = Event.find_by(id: params[:id])
        return error!("Event not found or already deleted", 404) unless event.present?

        event.destroy
        { deleted_event: params[:id] }
      end
    end
  end
end
