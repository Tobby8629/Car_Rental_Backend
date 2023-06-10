Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/register/:username', to: 'api/v1/users#register'
      get '/login/:username', to: 'users#login'
      
      resources :cars, only: [:index, :create, :destroy, :show] do
        member do
          delete :delete
        end
        collection do
          get :user_cars
        end
      end

      resources :users, only: [:index, :create] do
        resources :reservations, only: %i[index create show update destroy]
      end
    end
  end
end
