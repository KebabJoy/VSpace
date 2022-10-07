Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :api do
    scope module: :v1 do
      resource :clients, only: [:create, :show] do
        post :sign_in, on: :collection
      end

      resource :admins, only: [:create, :show] do
        post :sign_in, on: :collection
      end

      resource :editors, only: [:create, :show] do
        post :sign_in, on: :collection
      end

      resource :managers, only: [:create, :show] do
        resource :exchanges, only: :create
        post :sign_in, on: :collection
      end

      resource :exchanges, only: [:create]
    end
  end
end
