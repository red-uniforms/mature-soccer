Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { sessions: "user/sessions" },
             :path_names => {
              :sign_in => 'login',
              :sign_out => 'logout',
              :sign_up  => 'signup'
             }

  resources :users, only: [:index]

  resources :teams,
            param: :team_url, constraints: { :team_url => /[a-z0-9_-]{4,20}/},
            only: [:index, :new, :show, :create, :destroy] do
    member do
      post '', to: 'teams#join'
    end
  end

  resources :user_infos, only: [:destroy]

end