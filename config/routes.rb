BaseApp::Application.routes.draw do

  resources :morale

  get 'notifications/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",:registrations => "users/registrations"}

  get "home/index"
  resources :war
  resources :army do
    collection do
      resources :recruit
    end
  end
  resources :market
  resources :structures
  resources :items
  resources :spells do
    member do
      get 'cast', action: :cast
    end
  end
  resources :activities do
    collection do
      post 'explore', action: :explore
      post 'collect', action: :collect
      post 'build', action: :build
      post 'destroy', action: :destroy
      post 'disband', action: :disband
      post 'recruit', action: :recruit
      post 'party', action: :party
      post 'payoff', action: :payoff
    end
  end
  get "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

  root :to => "homes#index"

end
