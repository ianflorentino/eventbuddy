class UpdateUserOp < Backend::Op
  include Mixins::UserManagementOp

  attr_reader :updated_user

  protected

  def perform
    user = current_user
    patch_attributes(user)

    user.save!

    user.reload
    @updated_user = user

    true
  end

end
