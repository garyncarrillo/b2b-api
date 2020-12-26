Rails.application.routes.draw do
  devise_scope :customer_user do
    post "/sign_up" => "customer/registrations#create"
  end

  devise_for :customer_users,
             path: '',
             path_name: {
               sign_in: 'sign_in',
               sign_out: 'sign_out'
             },
             controllers: {
               sessions: 'customer/sessions',
               registrations: 'customer/registrations',
               passwords: 'customer/passwords',
             }

 devise_for :admin_users,
            path: 'admin',
            path_name: {
              sign_in: 'sign_in',
              sign_out: 'sign_out'
            },
            controllers: {
              sessions: 'admin/sessions',
              passwords: 'admin/passwords',
              invitations: 'admin/invitations',
            }

  namespace :customer, path: nil do
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
        get :'bids/last', controller: :products, action: :last_bid
        get :bids
      end
    end

    resources :auctions, only: %i(index show) do
      member do
        post :join
        post :upload_voucher
        resource :favourite, only: %i(create destroy), controller: 'auction_favourites'
      end

      collection do
        get :search
        get :joined
      end
    end

    resources :sellers, only: %i(show)
    resources :bids, only: %i(create index)
  end

  namespace :admin do
    resource :user, only: %i(show update), controller: :user
    resources :auctions, except: %i(new edit) do
      member do
        put :publish
        put :assign_products
        get :customers
        put :start
        put :finish
      end
    end
    resources :categories, except: %i(new edit show)
    resources :articles, except: %i(new edit show)

    resources :products, except: %i(new edit) do
      member do
        get :bids
        get :'bids/last', controller: :products, action: :last_bid
        post :assign_winner
        post :assign_winner_on_line
        post :bidding
      end
    end
    resources :sellers, except: %i(new edit show)
    resources :on_site_users, except: %i(new edit show) do
      member do
        post :assign_palette
        delete :unassign_palette
      end

      collection do
        get :verify
      end
    end
    resource :global_data, only: %i(show)
    resources :users, except: %i(new show)
    resources :bids, only: %i(create index)

    resources :customers, only: %i(index) do
      member do
        post :approve_pay
        post :activate
        delete :deactivate
      end
      collection do
        get :search
      end
    end

    namespace :stats, path: nil do
      resources :customers, only: [] do
        collection do
          get :'anality', action: :anality
        end
      end
    end
  end
end
