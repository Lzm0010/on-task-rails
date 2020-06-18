Rails.application.routes.draw do
  root 'welcome#index'
  resources :tasks, only: [:create, :show, :index, :update, :destroy]
  resources :notes, only: [:create, :show, :index, :update, :destroy]
  resources :goals, only: [:create, :index, :update, :destroy]
  resources :projects, only: [:create, :index, :update, :destroy]
  # resources :planners
  resources :users, only: [:create, :update, :destroy]
  post '/login', to: 'auth#create'
end
