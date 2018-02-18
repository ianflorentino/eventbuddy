module Mixins
  module PasswordManagementOp
    extend ::ActiveSupport::Concern
    
    included do
      fields :password, 
             :password_confirmation

      validates :password, presence: true 
      validates :password_confirmation, presence: true, allow_nil: true
    end


    # if no password_confirmation was provided to this form, use the password
    # if there was a password_confirmation but it's blank or any other value, use it
    def detected_password_confirmation
      return self.password if self.password_confirmation.nil?
      self.password_confirmation
    end
  end
end
