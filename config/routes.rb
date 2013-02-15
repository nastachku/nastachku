Nastachku::Application.routes.draw do

  root to: "web/welcome#index"

  mount Ckeditor::Engine => '/ckeditor'

  scope :module => :web do
    resources :users, only: [:new, :create, :index]
    resources :pages, only: [:show]
    resource :session, only: [:new, :create, :destroy]
    resources :news, only: [:index]
    resource :remind_password, only: [:new, :create]


    resource :account, olny: [:edit, :update] do
      scope :module => :account do
        resource :password, only: [:edit, :update]
      end
    end

    namespace :admin do
      resources :pages
      resources :news
      resources :users

      root to: "welcome#index"
    end
  end

end
