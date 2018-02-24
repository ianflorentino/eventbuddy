module V1
  class UserAPI < Base
    resource :users do
      get '/', skip_authorization: true do
        User.all
      end

      desc 'get user'
      get ':id' do
        user = User.find(params[:id])
        user
      end

      # TODO:refactor implement shared params modules
      desc 'signup and create a user'
      params do
        optional 'first_name', type: String, allow_blank: false
        optional 'last_name', type: String, allow_blank: false
        requires 'email', type: String, allow_blank: false
        requires 'password', type: String, allow_blank: false
        requires 'password_confirmation', type: String, allow_blank: false
        requires 'username', type: String, allow_blank: false
      end
      post '', skip_authorization: true do
        op = SignupOp.new(nil, params)
        op.submit
          
        return return_error(op, 400) unless op.errors.blank?
        op.user
      end

      desc "update a user's account"
      params do
        optional 'first_name', type: String, allow_blank: false
        optional 'last_name', type: String, allow_blank: false
        optional 'email', type: String, allow_blank: false
        optional 'password', type: String, allow_blank: false
        optional 'password_confirmation', type: String, allow_blank: false
        optional 'username', type: String, allow_blank: false
      end
      put '', skip_authorization: true do
        op = UpdateUserOp.new(current_user, params)
        op.submit

        return return_error(op, 400) unless op.errors.blank?
        op.updated_user
      end

      desc "delete a user"
      delete ':id' do
        user = User.find_by(id: params[:id])
        return return_error("User not found or already deleted", 404) unless user.present?

        user.destroy
        { deleted_user: params[:id] }
      end
    end
  end
end
