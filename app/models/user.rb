class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :doorkeeper

  has_many :event_users
  has_many :events, through: :event_users
  has_and_belongs_to_many :friends,
      class_name: "User", 
      join_table:  :friendships, 
      foreign_key: :user_id, 
      association_foreign_key: :friend_user_id

  # Overwritten method for authenticating by either username or email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    return unless login
    where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                  { value: login.downcase }]).first
  end

  attr_accessor :login

  def login
    @login || username || email
  end
end
