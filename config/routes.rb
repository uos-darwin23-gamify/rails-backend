Rails.application.routes.draw do
  devise_for :users, path: "api/auth", path_names: {
                                         sign_in:      "login",
                                         sign_out:     "logout",
                                         registration: "signup"
                                       },
                     controllers: {
                       sessions:      "users/sessions",
                       registrations: "users/registrations"
                     }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  scope "api" do
    get "/auth/status", to: "users/authentication_status#index"

    scope "admin" do
      get "pre-authorized-emails", to: "admin/pre_authorized_emails#all_pre_authorized_emails"
      post "pre-authorized-emails", to: "admin/pre_authorized_emails#create_pre_authorized_email"
      put "pre-authorized-emails", to: "admin/pre_authorized_emails#update_pre_authorized_email"
      delete "pre-authorized-emails", to: "admin/pre_authorized_emails#delete_pre_authorized_email"
    end

    get "challenges", to: "users/challenges#all_challenges"
    get "challenge", to: "users/challenges#challenge"
    post "challenge", to: "users/challenges#submit_challenge_solution"
  end

  scope "api/socket-server" do
    post "/auth/status", to: "socket_server/authentication_status#index"
  end
end
