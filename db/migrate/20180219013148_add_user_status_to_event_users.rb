class AddUserStatusToEventUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :event_users, :user_status, :integer, default: 0
  end
end
