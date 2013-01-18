Nastachku::Application.routes.draw do

  root to: "web/home#index", as: :home

  scope :module => :web do
    resource :session, only: [:new, :create, :delete]
    resources :users
  end

  namespace :admin do
    resources :users
  end

end
