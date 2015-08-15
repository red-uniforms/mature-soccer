Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { sessions: "user/sessions" },
             :path_names => {
              :sign_in => 'login',
              :sign_out => 'logout',
              :sign_up  => 'signup'
             }

  resources :users, only: [:index]
  resources :teams, only: [:index, :new, :create, :show]
  
  get 'team/:team_url', to: 'teams#show', constraints: { :team_url => /[a-z0-9_-]{4,20}/}

end
