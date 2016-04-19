Nastachku::Application.routes.draw do
  namespace :web do
    namespace :admin do
      get 'afterparty_tickets/index'
    end
  end

  require 'admin_constraint'

  get "audits/index"

  get "/404", to: "web/errors#not_found"
  get "/500", to: "web/errors#internal_server_error"
  get "/banned", to: "web/errors#banned"
  mount Preview => 'mailer_preview'

  root to: "web/welcome#index"

  mount Ckeditor::Engine => '/ckeditor'

  # FIXME
  # omniauth-facebook, omniauth-twitter
  get '/auth/:provider/callback', to: 'web/social_networks#auth'

  get '/auth/failure', to: 'web/social_networks#failure'

  namespace :api do
    resources :companies
    resources :cities
    resources :halls, only: [] do
      put :sort, on: :collection
    end
    resource :order, only: [] do
      get :prices, on: :member
    end

    resources :lectures do
      scope module: :lectures do
        resource :lecture_votings, only: [:create, :destroy]
        resource :listener_votings, only: [:create, :destroy]
        resource :feedbacks, only: [:create, :destroy]
      end
    end

    resources :events, only: [:index] do
      collection do
        get :my_programm
      end
      scope module: :events do
        resource :event_votings, only: [:create, :destroy]
      end
    end
  end

  scope module: :web do
    resources :users, only: [:new, :create, :index]
    resources :welcome, only: [:index]
    resources :lectures, only: [:index]
    resources :speaker, only: [:index]
    resources :contacts, only: [:index]
    resources :pages, only: [:show]
    resources :promo, only: [:show]
    get '/promo', to: redirect('/promo/programmers')
    resources :news, only: [:index]
    resources :user_lectures, only: [:index]
    resources :lectors, only: [:index]
    resources :user_lectures, only: [:index]
    resource :remind_password, only: [:new, :create]
    resource :session, only: [:new, :create, :destroy]
    resource :schedule, only: [:show]
    resource :buy_now, only: [:new, :create] do
      get :success
    end
    get 'buy_now', to: 'buy_nows#new'

    resource :user, only: [] do
      get :activate
    end

    resources :coupons, only: [:create, :show]
    resource :account, only: [:edit, :update] do
      scope module: :account do
        resource :password, only: [:edit, :update]
        resources :lectures, only: [:new, :create, :update, :edit]

        resources :orders, only: [:update] do
          put :pay, on: :member

          collection do
            post :approve
            post :cancel
            post :decline
          end
        end
        resources :shirt_orders, only: [:new, :create]
        resource :tickets, only: [] do
          collection do
            post :activate
            get :activation
          end
        end

        resources :order_options, only: :create
        get "code/:code" => "discounts#show"
        post "discount" => "accounts#edit"
        resource :buy, only: [] do
          put :pay
        end
        resources :promo_codes, only: []  do
          member do
            put :accept
          end
        end

        resource :shop, only: [:show]
      end
    end

    resource :social_networks, only: [] do
      get :authorization, on: :member
    end

    resource :social_wall, only: [:show]

    namespace :registrator do
      root to: "users#index"
      resource :users, only: [:index, :new, :create] do
        get :with_badge
        member do
          put :give_badge
        end
      end
    end

    post 'payments/paid/payanyway', to: 'payments#paid_payanyway'
    match 'payments/success/payanyway', to: 'payments#success_payanyway', via: [:get, :post]
    match 'payments/decline/payanyway', to: 'payments#decline_payanyway', via: [:get, :post]
    match 'payments/cancel/payanyway', to: 'payments#cancel_payanyway', via: [:get, :post]

    post 'payments/check_order/yandexkassa', to: 'payments#check_order_yandexkassa'
    post 'payments/payment_aviso/yandexkassa', to: 'payments#payment_aviso_yandexkassa'
    match 'payments/success/yandexkassa', to: 'payments#success_yandexkassa', via: [:get, :post]
    match 'payments/fail/yandexkassa', to: 'payments#fail_yandexkassa', via: [:get, :post]

    namespace :admin do
      resources :users_lists, except: [:edit, :update] do
        member do
          put :accept
          put ":user_id" => "users#pay_part"
          post "create_paid_part" => "users#create_paid_part"
        end
      end
      resources :lectures do
        collection do
          get 'report'
        end
      end
      resources :pages
      resources :news
      resources :users, except: [:new, :create] do
        member do
          get :tickets
          patch :activate_code
          patch :cancel_ticket
        end
      end
      resources :audits, only: [:index]
      resources :topics
      resources :distributors
      resources :ticket_codes, only: [:index, :new, :create, :destroy, :show] do
        member do
          post :activate
        end
      end
      resources :tickets, only: [:index, :show]
      resources :afterparty_tickets, only: [:index, :show]
      resources :campaigns

      resources :coupons do
        collection do
          get :reports
        end
      end
      resources :events
      resources :workshops
      resources :halls
      resources :event_breaks
      resources :orders, only: [:index, :edit, :update, :show]
      resource :mailers, only: [] do
        get :index
        post :broadcast_to_not_attended
        post :broadcast
        post :preview
        post :broadcast_to_admins
      end
      resources :reports, only: [:index, :show] do
        member do
          get :download
        end
      end
      mount Resque::Server, at: "resque", constraints: AdminConstraint.new, as: 'resque'

      root to: "welcome#index"
    end # admin
  end # web

  match '*unmatched_route', to: "web/errors#not_found", via: :all
end
