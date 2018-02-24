module Mixins
  module UserManagementOp
    extend ::ActiveSupport::Concern
    
    included do
      fields :email, 
             :username,
             :first_name,
             :last_name
    end
  end
end
