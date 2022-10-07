Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :api do
    scope module: :v1 do
      resource :clients, only: [:create] do
        get :sign_in, on: :collection
      end

      resource :admins, only: [:create] do
        get :sign_in, on: :collection
      end

      resource :editors, only: [:create] do
        get :sign_in, on: :collection
      end

      resource :leaders, only: [:create] do
        get :sign_in, on: :collection
      end
    end
  end
end
