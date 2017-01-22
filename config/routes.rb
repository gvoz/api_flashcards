ApiFlashcards::Engine.routes.draw do
  root to: 'home#index'

  scope module: 'api' do
    namespace :v1 do
      get  :cards,  to: 'cards#index'
      post :cards,  to: 'cards#create'
      get :cards, to: 'cards#show'
      post :cards, to: 'cards#review'
    end
  end
end
