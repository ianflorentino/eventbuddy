class SignupOp < Backend::Op
  include Mixins::UserManagementOp
  include Mixins::PasswordManagementOp

  validates :email, :username, presence: true

  attr_reader :user

  protected

  def perform
    @user = build_user
    user.save!

    true
  end

  def build_user
    User.new.tap do |u|
      u.email    = email
      u.password = password
      u.username = username
    end
  end

end
