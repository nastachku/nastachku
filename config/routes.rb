Nastachku::Application.routes.draw do

  get "audits/index"

  match "/404", :to => "web/errors#not_found"
  match "/500", :to => "web/errors#internal_server_error"

  root to: "web/welcome#index"

  mount Ckeditor::Engine => '/ckeditor'

  namespace :api do
    resources :companies
    resources :cities
  end

  scope :module => :web do
    resources :users, only: [:new, :create, :index]
    resource :user do
      get :activate
    end

    resources :pages, only: [:show]
    resource :session, only: [:new, :create, :destroy]
    resources :news, only: [:index]
    resource :remind_password, only: [:new, :create]


    resource :account, only: [:edit, :update] do
      scope :module => :account do
        resource :password, only: [:edit, :update]
      end
    end

    resources :lectors, only: [ :index ]

    namespace :admin do
      resources :pages
      resources :news
      resources :users
      resources :audits, only: [ :index ]
      resources :topics

      root to: "welcome#index"
    end
  end

end
