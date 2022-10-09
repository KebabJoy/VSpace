Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :api do
    scope module: :v1 do
      resources :clients, only: [:create, :show, :index] do
        collection do
          post :sign_in
          get :leaderboard
          get :balance_history
          get :colleagues
        end
      end

      resource :admins, only: [:create, :show] do
        post :sign_in, on: :collection
      end

      resource :editors, only: [:create, :show] do
        post :sign_in, on: :collection
      end

      resource :managers, only: [:create, :show] do
        resource :exchanges, only: :create, controller: 'managers/exchange'
        resource :news, only: :create, controller: 'managers/exchange'
        resource :events, only: :create, controller: 'managers/exchange'
        resources :tasks, only: :index, controller: 'managers/tasks' do
          post :move, on: :member
        end

        post :sign_in, on: :collection
      end

      resource :exchanges, only: [:create]
      resources :news, only: [:index]
      resources :products, only: [:index] do
        post :buy, on: :collection
        post :lottery, on: :collection
      end

      resources :events, only: [:index] do
        post :take, on: :collection
      end
    end
  end
end
