Rails.application.routes.draw do
  get "/" => "welcome#index"

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  namespace :api do
    namespace :v1 do
      # user authentication
      post "signin" => "authentication#signin"
      post "signup" => "authentication#signup"
      post "refresh_token" => "authentication#refresh_token"
      delete "logout" => "authentication#logout"

      # profile detail
      get    "profile" => "profile#show"
      get    "profile/:id" => "profile#show_profile"
      put    "profile" => "profile#update"
      post   "profile/upload_avatar" => "profile#upload_avatar"

      # Doctor wall
      post   "wall" => "wall#create"
      get    "wall" => "wall#show"
      put    "wall" => "wall#update"
      get    "wall/:uid" => "wall#show_wall"

      # Add skill
      post "wall/skills" => "wall#add_skills"
    end
  end

end
