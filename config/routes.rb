Nastachku::Application.routes.draw do

  root to: "web/home#index"

  scope :module => :web do
    resources :users, only: [:new, :create, :index]

    namespace :account do
      resource  :session,  only: [:new, :create, :destroy]
      resources :accounts, only: [:edit, :update]
    end

    namespace :admin do
      resources :pages
      resources :news

      root to: "home#index"
    end
  end

end
