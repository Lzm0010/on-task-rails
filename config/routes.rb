Rails.application.routes.draw do
  resources :tasks, only: [:create, :show, :index, :update, :destroy]
  resources :notes, only: [:create, :show, :index, :update, :destroy]
  resources :goals, only: [:create, :index, :update, :destroy]
  resources :projects, only: [:create, :index, :update, :destroy]
  # resources :planners
  resources :users, only: [:create, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
