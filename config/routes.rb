# -*- coding: utf-8 -*-
Nastachku::Application.routes.draw do

  get "audits/index"

  match "/404", to: "web/errors#not_found"
  match "/500", to: "web/errors#internal_server_error"
  match "/banned", to: "web/errors#banned"

  root to: "web/welcome#index"

  mount Ckeditor::Engine => '/ckeditor'

  # omniauth-facebook, omniauth-twitter
  get '/auth/:action/callback' => 'web/social_networks'
  get '/auth/:action/failure' => 'web/social_networks#failure'

  namespace :api do
    resources :companies
    resources :cities
    resources :halls, only: [] do
      put :sort, on: :collection
    end

    resources :lectures do
      scope module: :lectures do
        resource :lecture_votings, only: [:create, :destroy]
        resource :listener_votings, only: [:create, :destroy]
      end
    end

    resources :events, only: [:index] do
      scope module: :events do
        resource :event_votings, only: [:create, :destroy]
      end
    end

  end

  scope module: :web do
    resources :users, only: [:new, :create, :index] do
      member do
        put :attend
      end
    end
    resources :welcome, only: [ :index ]
    resources :lectures, only: [ :index ]
    resources :pages, only: [:show]
    resources :news, only: [:index]
    resources :user_lectures, only: [:index]
    resources :lectors, only: [:index]
    resources :user_lectures, only: [:index]
    resource :remind_password, only: [:new, :create]
    resource :session, only: [:new, :create, :destroy]
    resource :schedule, only: [:show]

    resource :user, only: [] do
      get :activate
    end

    resource :account, only: [:edit, :update] do
      scope module: :account do
        resource :password, only: [:edit, :update]
        resource :social_networks, only: [] do
          #FIXME по REST тут должен быть put. Решить проблему вызова экшена из другого контроллера
          get :link_twitter
          put :unlink_twitter
        end

        resources :lectures, only: [ :new, :create, :update ]
        resources :orders, only: [:update] do
          put :pay, on: :member

          collection do
            post :approve
            post :cancel
            post :decline
          end
        end
        resources :shirt_orders, only: [:new, :create]
<<<<<<< HEAD
        resources :ticket_orders, only: :create
        resources :order_options, only: :create
=======
        resources :ticket_orders, only: [:new, :create]
>>>>>>> 940c36cc6eab2279d083dac39d5d976c4827fac5
        resources :promo_codes, only: []  do
          member do
            put :accept
          end
        end
      end
    end

    resource :social_networks, only: [] do
      get :authorization, on: :member
    end

    namespace :admin do
      resources :lectures
      resources :pages
      resources :news
      resources :users
      resources :audits, only: [:index]
      resources :topics
      resources :user_events do
        put :change_state
      end

      resources :events
      resources :workshops
      resources :halls
      resources :event_breaks
      resources :orders, only: [:index]
      resource :mailers, only: [] do
        get :index
        post :deliver
      end

      root to: "welcome#index"
    end
  end

  match '*unmatched_route', to: "web/errors#not_found"
end
