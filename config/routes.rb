Nastachku::Application.routes.draw do

  match "/404", :to => "web/errors#not_found"
  match "/500", :to => "web/errors#internal_server_error"

  root to: "web/welcome#index"

  mount Ckeditor::Engine => '/ckeditor'

  namespace :api do
    resources :companies
    resources :cities
  end

  scope :module => :web do
    resource :user do
      get :activate
    end
    resources :users, only: [:new, :create, :index] do
      resources :events, only: [:new, :create]
    end

    resources :workshops, only: [:show]

    resources :pages, only: [:show]
    resource :session, only: [:new, :create, :destroy]
    resources :news, only: [:index]
    resource :remind_password, only: [:new, :create]

    resources :events, only: [:new, :create]
    namespace :account do
      resource :password, only: [:edit, :update]
      resources :accounts, only: [:edit, :update]
    end

    resources :lectors, only: [ :index ]

    namespace :admin do
      resources :pages
      resources :news
      resources :users
      resources :audits, only: [ :index ]
      resources :topics
      resources :user_events do
        put :change_state
      end

      resources :events
      resources :workshops
      resources :halls
      resources :event_breaks

      root to: "welcome#index"
    end
  end

end
