Nastachku::Application.routes.draw do

  root to: "web/welcome#index"

  mount Ckeditor::Engine => '/ckeditor'

  scope :module => :web do
    resources :members, only: [:new, :create, :index]
    resource :session, only: [:new, :create, :destroy]

    namespace :account do
      resources :members, only: [:edit, :update]
      resources :speakers, only: [:edit, :update]
    end

    namespace :admin do
      resources :pages
      resources :news
      resources :users, only: [:index, :destroy]
      resources :members, only: [:new, :create, :edit, :update, :show]
      resources :speakers, only: [:new, :create, :edit, :update, :show]
      root to: "welcome#index"
    end
  end

end
