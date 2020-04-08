Rails.application.routes.draw do
  devise_scope :user do
    post "/sign_up" => "registrations#create"
  end

  devise_for :users,
             path: '',
             path_name: {
               sign_in: 'sign_in',
               sign_out: 'sign_out'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations',
               passwords: 'passwords',
             }

  resource :user, only: %i(show update), controller: :user
  resources :categories, except: %i(new edit)
  resources :articles, except: %i(new edit)
  resources :products, except: %i(new edit)
  resources :favourites, only: %i(index)

  resources :articles, path: :article, only: [] do
    member do
      resource :favourite, only: %i(create destroy), controller: 'article_favourites'
    end
  end

  resources :products, path: :product, only: [] do
    member do
      resource :favourite, only: %i(create destroy), controller: 'product_favourites'
    end
  end

  resources :auctions, except: %i(new edit) do
    member do
      resource :favourite, only: %i(create destroy), controller: 'auction_favourites'
    end

    collection do
      get :search
    end
  end
end
