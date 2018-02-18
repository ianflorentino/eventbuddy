class Event < ApplicationRecord
  has_many :event_users
  has_many :users, through: :event_users
  has_many :comments, as: :commentable, dependent: :destroy

  has_attached_file :main_image, styles: { thumbnail: "60x60#" }
  validates_attachment_content_type :main_image, content_type: /\Aimage\/.*\Z/
end
