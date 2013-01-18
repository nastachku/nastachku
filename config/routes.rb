Nastachku::Application.routes.draw do

  root to: "web/home#index"

  scope :module => :web do
    resources :users, only: [:new, :create, :index]

    namespace :user do
      resource :session, only: [:new, :create, :destroy]
      resources :accounts, only: [:edit, :update]
    end
  end

end
