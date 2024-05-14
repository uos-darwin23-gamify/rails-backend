Rails.application.routes.draw do
  devise_for :users, path: "api/auth", path_names: {
                                         sign_in:      "login",
                                         sign_out:     "logout",
                                         registration: "signup"
                                       },
                     controllers: {
                       sessions:      "users/sessions",
                       registrations: "users/registrations",
                       passwords:     "users/passwords"
                     }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  scope "api" do
    scope "auth" do
      get "status", to: "users/authentication_status#index"
      get "info", to: "users/authentication_status#info"
    end

    scope "admin" do
      get "pre-authorized-emails", to: "admin/pre_authorized_emails#all_pre_authorized_emails"
      post "pre-authorized-emails", to: "admin/pre_authorized_emails#create_pre_authorized_email"
      put "pre-authorized-emails", to: "admin/pre_authorized_emails#update_pre_authorized_email"
      delete "pre-authorized-emails", to: "admin/pre_authorized_emails#delete_pre_authorized_email"

      get "challenge-editor-all", to: "admin/challenge_editor#all_challenges"
      post "scq-challenge-create", to: "admin/challenge_editor#create_scq"
      post "mcq-challenge-create", to: "admin/challenge_editor#create_mcq"
      post "blocks-challenge-create", to: "admin/challenge_editor#create_blocks"

      get "users", to: "admin/users#all_users"
      delete "users/:id", to: "admin/users#destroy"
      put "users/:id", to: "admin/users#promote_to_admin"
    end

    get "placement-challenges-finished", to: "users/challenges#placement_challenges_status"
    get "challenges", to: "users/challenges#all_challenges"
    get "challenges-available", to: "users/challenges#not_all_challenges_finished"
    get "challenge", to: "users/challenges#challenge"
    post "challenge", to: "users/challenges#submit_challenge_solution"
    # post "consent", to: "users/consent#submit_consent"
    # get "consent", to: "users/consent#consent"
    post "change-password", to: "users/settings#change_password"
    post "email-notifications-setting", to: "users/settings#change_email_notifications_setting"
    get "email-notifications-setting", to: "users/settings#email_notifications_setting"
    post "unsubscribe", to: "users/settings#unsubscribe"
    get "unsubscribe", to: "users/settings#unsubscribe"

    scope "leaderboard" do
      get "avatar-dropdown-info", to: "users/leaderboard#avatar_dropdown_info"
      get "data", to: "users/leaderboard#leaderboard"
    end
  end

  scope "api/socket-server" do
    post "/auth/status", to: "socket_server/authentication_status#index"
    post "/activity/connect", to: "socket_server/activity#connect"
    post "/activity/disconnect", to: "socket_server/activity#disconnect"
  end
end
