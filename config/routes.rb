Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  match '/signin' => 'sessions#create', :via => [:post], :as => 'sessions_create'
  match '/signin' => 'sessions#new', :via => [:get], :as => 'sessions_signin'
  match '/signout' => 'sessions#destroy', :via => [:get], :as => 'sessions_signout'
  match '/' => 'contests#dashboard', :via => [:get], :as => 'contests_dashboard'
  match '/leaderboard' => 'contests#leaderboard', :via => [:get], :as => 'contests_leaderboard'
  match '/signup' => 'contests#signup', :via => [:get], :as => 'contests_signup'
  post 'contests/create'
  post 'contests/validate'
  
  match '/:id' => 'contests#index', :via => [:get]
end
