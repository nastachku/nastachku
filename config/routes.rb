Nastachku::Application.routes.draw do

  root to: "web/welcome#index"

  scope :module => :web do
    resources :users, only: [:new, :create, :index]
    resource :session, only: [:new, :create, :destroy]

    namespace :account do
      resources :accounts, only: [:edit, :update]
    end

    namespace :admin do
      resources :pages
      resources :news

      root to: "welcome#index"
    end
  end

end
