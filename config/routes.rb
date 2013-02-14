Nastachku::Application.routes.draw do

  root to: "web/welcome#index"

  mount Ckeditor::Engine => '/ckeditor'

  namespace :api do
    resources :companies
  end

  scope :module => :web do
    resources :users, only: [:new, :create, :index]
    resources :pages, only: [:show]
    resource :session, only: [:new, :create, :destroy]
    resources :news, only: [:index]
    resource :remind_password, only: [:new, :create]

    namespace :account do
      resource :password, only: [:edit, :update]
      resources :accounts, only: [:edit, :update]
    end

    namespace :admin do
      resources :pages
      resources :news
      resources :users

      root to: "welcome#index"
    end
  end

end
