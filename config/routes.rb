ApiFlashcards::Engine.routes.draw do
  apipie
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :cards, only: [:create, :index, :show]
      post :review, to: 'cards#review'
    end
  end
end
