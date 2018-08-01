Rails.application.routes.draw do
    root to: "events#index"

    devise_for :users, controllers: { registrations: 'users/registrations' }
    resources :users, only: [:index, :show, :edit, :update]
    resources :personal_messages, only: [:new, :create]
    resources :conversations, only: [:index, :show]

    mount ActionCable.server => '/cable'

    resources :events do
      resources :tickets, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

end
