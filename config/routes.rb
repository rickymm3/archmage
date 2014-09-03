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
      post 'explore', :action => :explore
    end
  end
  get "/admin" => "admin/base#index", :as => "admin"

  namespace "admin" do
    resources :users
  end

  root :to => "homes#index"

end
