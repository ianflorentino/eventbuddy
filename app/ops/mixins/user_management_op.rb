module Mixins
  module UserManagementOp
    extend ::ActiveSupport::Concern
    
    included do
      fields :email, 
             :username
    end
  end
end
