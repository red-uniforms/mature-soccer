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
            param: :team_url, constraints: { :team_url => /[a-z0-9_-]{3,20}/},
            only: [:index, :new, :show, :create, :destroy] do
    member do
      post '', to: 'teams#join'
      post 'captain', to: 'teams#captain'
      scope '/:user_info_id' do
        post '', to: 'teams#approve'
        delete '', to: 'teams#reject'
      end
    end
  end

  resources :cups,
            param: :cup_url, constraints: { :cup_url => /[a-z0-9_-]{4,20}/},
            only: [:index, :new, :show, :create] do
    member do
      post '', to: 'cups#join'

      get '/schedule', to: 'cups#schedule'
      get '/rank', to: 'cups#rank'
      get '/records', to: 'cups#records'
      scope '/organize' do
        get '', to: 'cups#organize'
      end

      get '/notices', to: 'cups#notices'

      post '/groups', to: 'groups#create'
      get '/groups/new', to: 'groups#new'
      get '/groups/:id', to: 'groups#show'
      delete '/groups/:id', to: 'groups#destroy'
      patch '/groups/:id/edit', to: 'groups#edit'

      scope '/:team_applicant_id', constraints: { :team_applicant_id => /[0-9]+/} do
        post '', to: 'cups#approve'
        delete '', to: 'cups#reject'
      end
    end
  end

  resources :organizers, only: [:create]

  resources :user_infos, only: [:destroy]
  resources :team_applicants, only: [:create, :destroy]

  resources :notices, only: [:show, :new, :create, :update, :edit, :destroy]

  resources :matches, only: [:new, :create, :show, :destroy] do
    member do
      post '/referee', to: 'matches#referee'
      post '/player/:user_id', to: 'matches#player'
      post '/record', to: 'matches#record'
      get '/record', to: 'matches#record'
      delete '/event/:event_id', to: 'events#destroy'
      post '/status', to: 'matches#status'
    end
  end

end
