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
      scope '/:team_applicant_id' do
        post '', to: 'cups#approve'
        delete '', to: 'cups#reject'
      end
      get '/schedule', to: 'cups#schedule'
    end
  end

  resources :user_infos, only: [:destroy]
  resources :team_applicants, only: [:destroy]

end