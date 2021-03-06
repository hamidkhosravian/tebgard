Rails.application.routes.draw do
  get "/" => "welcome#index"

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  namespace :api do
    namespace :v1 do
      # user authentication
      post     "signin"        => "authentication#signin"
      post     "signup"        => "authentication#signup"
      post     "refresh_token" => "authentication#refresh_token"
      delete   "logout"      => "authentication#logout"

      # profile detail
      get      "profile"      => "profile#show"
      get      "profile/:uid" => "profile#show_profile"
      put      "profile"      => "profile#update"
      post     "profile/upload_avatar" => "profile#upload_avatar"

      # Doctor wall
      post     "wall"       => "wall#create"
      get      "wall"       => "wall#show"
      put      "wall"       => "wall#update"
      get      "walls/:uid" => "wall#show_wall"
      post     "walls/:uid/favorite"   => "wall#favorite"
      delete   "walls/:uid/unfavorite" => "wall#unfavorite"

      # Add skill
      post     "wall/skills" => "wall#add_skills"
      delete   "wall/skills" => "wall#remove_skills"

      # follower and following
      get      "wall/followers"     => "relationship#followers"
      get      "wall/following"     => "relationship#following"
      post     "wall/:uid/follow"   => "relationship#create"
      delete   "wall/:uid/unfollow" => "relationship#destroy"
      get      "walls/:uid/offices" => "office#wall_offices"

      # Doctor office
      post     "offices"      => "office#create"
      get      "offices"      => "office#index"
      get      "offices/:uid" => "office#show"
      put      "offices/:uid" => "office#update"
      delete   "offices/:uid" => "office#destroy"
      post     "offices/:uid/upload_file" => "office#upload_file"
      post     "offices/:uid/activities"   => "office#add_office_activities"

      #like or unlike office
      post     "offices/:uid/like"   => "office#like"
      delete   "offices/:uid/unlike" => "office#unlike"

      # office working hours
      get      "offices/:uid/working_hours" => "working_hours#index"
      get      "offices/:uid/working_hours/filter" => "working_hours#show"
      post     "offices/:uid/working_hours" => "working_hours#create"
      put      "offices/:uid/days/:day/hours/:id" => "working_hours#update"
      delete   "offices/:uid/days/:day" => "working_hours#destroy_day"
      delete   "offices/:uid/days/:day/hours/:id" => "working_hours#destroy_hour"

      # office active or deactive special date
      get      "offices/:uid/availables" => "available#office_available_index"
      post     "offices/:uid/availables" => "available#office_available"
      put      "offices/:uid/availables/:id" => "available#office_update"
      delete   "offices/:uid/availables/:id" => "available#destroy"

      # find
      post     "offices/offices_by_activities" => "article#offices_find_by_activities"

      # find nearest
      post     "nearest/offices" => "find_nearest#office"
      post     "nearest/offices_by_skills" => "find_nearest#offices_by_skills"
      post     "nearest/offices_by_activities" => "find_nearest#offices_by_activities"

      # posts
      get      "posts"      => "post#index"
      get      "posts/:uid" => "post#show"
      post     "posts"      => "post#create"
      put      "posts/:uid" => "post#update"
      delete   "posts/:uid" => "post#destroy"
      get      "walls/:uid/posts" => "post#wall_posts"
      get      "posts/:uid/comments" => "post#comments"
      post     "posts/:uid/comments" => "post#add_comment"
      post     "posts/posts_by_tags" => "post#posts_find_by_tag"
      post     "posts/:uid/like"   => "post#like"
      delete   "posts/:uid/unlike" => "post#unlike"

      # posts
      get      "articles"      => "article#index"
      get      "articles/:uid" => "article#show"
      post     "articles"      => "article#create"
      put      "articles/:uid" => "article#update"
      delete   "articles/:uid" => "article#destroy"
      get      "walls/:uid/articles" => "article#wall_articles"
      post     "articles/:uid/upload_file" => "article#upload_file"
      get      "articles/:uid/comments"    => "article#comments"
      post     "articles/:uid/comments"    => "article#add_comment"
      post     "articles/articles_by_tags" => "article#articles_find_by_tag"
      post     "articles/:uid/like"   => "article#like"
      delete   "articles/:uid/unlike" => "article#unlike"

      # file
      delete   "file" => "file#delete_file"

      # comment
      delete   "comments/:uid" => "comment#destroy"
    end
  end
end
