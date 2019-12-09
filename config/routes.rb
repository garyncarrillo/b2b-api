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
             
  resource :users, only: %i(show)
end
