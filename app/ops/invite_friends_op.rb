class InviteFriendsOp < Backend::Op
  fields :id, :user_ids

  validates :id, :user_ids, presence: true

  protected

  def perform
    event = Event.find id

    # TODO implement something like pundit/policies
    if !event.user_admin?(current_user)
      errors.add(:current_user, "this action requires an Admin")
      return false
    end

    event.invite_users(user_ids)

    true
  end
end
