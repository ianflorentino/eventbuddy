class Event < ApplicationRecord
  has_many :event_users
  has_many :invited, through: :event_users, foreign_key: :user_id, source: :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_attached_file :main_image,
                    styles: { thumbnail: "60x60#" },
                    default_url: "#{Rails.public_path}/default_event.png"
  validates_attachment_content_type :main_image, content_type: /\Aimage\/.*\Z/

  # confirmed, undecided, declined, admins
  # confirmed_count, undecided_count, declined_count, admins_count
  # user_confirmed?, user_undecided?, user_declined?, user_admins?
  EventUser.user_statuses.keys.each do |key|
    string = key.include?("ed") ? key : key.pluralize
    define_method(string) do
      event_users.includes(:user).send(key).map(&:user)
    end

    define_method("#{string}_count") do
      event_users.send(key).count
    end

    define_method("user_#{string.singularize}?") do |user|
      event_users.send(key).pluck(:user_id).include?(user.id)
    end
  end

  def invite_users(user_ids)
    return false unless user_ids.is_a? Array

    user_ids.each do |id|
      event_users.create!(user_id: id)
    end
  end

  def make_users_admin(user_ids)
    return false unless user_ids.is_a? Array

    user_ids.each do |id|
      if invited.pluck(:id).include?(id)
        event_user = event_users.where(user_id: id).first
        event_user.admin!
      else
        event_users.create!(user_id: id).admin!
      end
    end
  end

  def remove_admins(user_ids)
    return false unless user_ids.is_a? Array

    user_ids.each do |id|
      event_user = event_users.where(user_id: id).first
      status = event_user.versions.last.reify.user_status
      event_user.send("#{status}!")
    end
  end
end
