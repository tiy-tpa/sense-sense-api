Rails.application.routes.draw do
  resources :games, only: [:create] do
    collection do
      post :move
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
