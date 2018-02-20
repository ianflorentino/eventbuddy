class EventUser < ApplicationRecord
  has_paper_trail # to track enum state

  belongs_to :event
  belongs_to :user

  enum user_status: {
    undecided: 0,
    confirmed: 1,
    declined: 2,
    admin: 3
  }
end
