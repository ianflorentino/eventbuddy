Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper
  mount ApplicationAPI => '/api'
end
