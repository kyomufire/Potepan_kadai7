Rails.application.routes.draw do

  devise_for :users, controllers:{
              path: "",
              path_names: {sign_up: "register", sign_in: "login", edit: "profile", sign_out: "logout"},
              controllers: {registrations: "registrations"}}

  resources :rooms, except: [:edit] do
    collection do
      get "search"
    end

    member do
      get "listing"
      get "pricing"
      get "description"
      get "photo_upload"
      get "location"
      delete :delete_photo
      post :upload_photo
    end

    resources :reservations
  end

  resources :reservations do
    member do
      get "confirm"
    end
  end

  get "pages/home"
  get "/account", to: "users#account"
  get "/dashboard", to: "users#dashboard"
  get "/users/:id", to: "users#show", as: "user"
  get "rooms/new", to: "rooms#new"
  get "/your_trips" => "reservations#your_trips"
  get "/your_reservations" => "reservations#your_reservations"
  get "search" => "pages#search"

  post "/users/edit", to: "users#update"

  root to: "pages#home"



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
