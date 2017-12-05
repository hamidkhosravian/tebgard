Rails.application.routes.draw do
  get "/" => "welcome#index"

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  namespace :api do
    namespace :v1 do
      # user authentication
      post "signin"        => "authentication#signin"
      post "signup"        => "authentication#signup"
      post "refresh_token" => "authentication#refresh_token"
      delete "logout"      => "authentication#logout"

      # profile detail
      get    "profile"     => "profile#show"
      get    "profile/:id" => "profile#show_profile"
      put    "profile"     => "profile#update"
      post   "profile/upload_avatar" => "profile#upload_avatar"

      # Doctor wall
      post   "wall"      => "wall#create"
      get    "wall"      => "wall#show"
      put    "wall"      => "wall#update"
      get    "wall/:uid" => "wall#show_wall"

      # Add skill
      post   "wall/skills" => "wall#add_skills"
      delete "wall/skills" => "wall#remove_skills"

      # Doctor office
      post     "office"      => "office#create"
      get      "office/:uid" => "office#show"
      put      "office/:uid" => "office#update"
      delete   "office/:uid" => "office#destroy"
      post     "office/:uid/upload_image" => "office#upload_image"

      # find nearest
      post   "nearest/offices" => "find_nearest#office"
      post   "nearest/offices_by_tags" => "find_nearest#offices_by_tags"

      # posts
      get       "posts"      => "post#index"
      get       "posts/:uid" => "post#show"
      post      "posts"      => "post#create"
      put       "posts/:uid" => "post#update"
      delete    "posts/:uid" => "post#destroy"
      post      "posts/posts_by_tags" => "post#posts_find_by_tag"

      # posts
      get       "articles"      => "article#index"
      get       "articles/:uid" => "article#show"
      post      "articles"      => "article#create"
      put       "articles/:uid" => "article#update"
      delete    "articles/:uid" => "article#destroy"
      post      "articles/:uid/upload_file" => "article#upload_file"
      post      "articles/articles_by_tags" => "article#articles_find_by_tag"

      # file
      delete    "file" => "file#delete_file"
    end
  end
end
