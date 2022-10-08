Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :api do
    scope module: :v1 do
      resource :clients, only: [:create, :show] do
        collection do
          post :sign_in
          get :leaderboard
        end
      end

      resource :admins, only: [:create, :show] do
        post :sign_in, on: :collection
      end

      resource :editors, only: [:create, :show] do
        post :sign_in, on: :collection
      end

      resource :managers, only: [:create, :show] do
        resource :exchanges, only: :create
        resource :news, only: :create
        resource :events, only: :create

        post :sign_in, on: :collection
      end

      resource :exchanges, only: [:create]
      resources :news, only: [:index]
      resources :products, only: [:index]
      resources :events, only: [:index] do
        post :take, on: :collection
      end
    end
  end
end
