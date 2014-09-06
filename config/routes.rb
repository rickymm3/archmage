BaseApp::Application.routes.draw do

  get 'notifications/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",:registrations => "users/registrations"}

  get "home/index"
  resources :war
  resources :army
  resources :market
  resources :structures
  resources :items
  resources :spells
  resources :activities do
    collection do
      post 'explore', action: :explore
      post 'collect', action: :collect
      post 'build', action: :build
      post 'destroy', action: :destroy
    end
  end
  get "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

  root :to => "homes#index"

end
