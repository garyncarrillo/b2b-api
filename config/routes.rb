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
  resources :categories, only: %i(index show)
  resources :favourites, only: %i(index)

  resources :articles, only: %i(index show) do
    member do
      resource :favourite, only: %i(create destroy), controller: 'article_favourites'
    end
  end

  resources :products, only: %i(index show) do
    member do
      resource :favourite, only: %i(create destroy), controller: 'product_favourites'
    end
  end

  resources :auctions, only: %i(index show) do
    member do
      resource :favourite, only: %i(create destroy), controller: 'auction_favourites'
    end

    collection do
      get :search
    end
  end

  namespace :admin do
    devise_for :users,
               path: '',
               path_name: {
                 sign_in: 'sign_in',
                 sign_out: 'sign_out'
               },
               controllers: {
                 sessions: 'admin/sessions',
                 registrations: 'admin/registrations',
                 passwords: 'admin/passwords',
               }

    resources :auctions, except: %i(new edit)
    resources :categories, except: %i(new edit show)
    resources :articles, except: %i(new edit show)
    resources :products, except: %i(new edit show)
    resources :sellers, except: %i(new edit show)
  end
end
