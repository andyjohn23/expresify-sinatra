class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  #posts routes

  get "/posts" do
    posts = Post.all.limit(10)
    updated_posts = posts.map do |post|
      {
        id: post.id,
        post_title: post.title,
        post_content: post.content,
      }
    end
    updated_posts.to_json
  end

  get "/user/posts/:id" do
      posts = Post.all.where(["user_id= ?", params[:id]]).order(updated_at: :desc)
      updated_posts = posts.map do |post|
        {
          id: post.id,
          title: post.title,
          content:post.content
        }
      end
      updated_posts.to_json
    
  end

  post "/posts" do
    post = Post.create(
      title:params[:title],
      content:params[:content],
      user_id:params[:user]
     )
    post.to_json
  end

  patch "/posts/:id" do
    post = Post.find(params[:id])
      updated_post = {
          id: post.id,
          title: post.title,
          content: post.content
        }
      updated_post.to_json
  end
  
  # User routes
  post "users/signup" do
    user = User.find_by(email:params[:email])

    if user == nil
      new_user = User.create(
        username:params[:username],
        email:params[:email],
        password:params[:password]
      )
      new_user.to_json
    else
      status 409
      { errors: "User already exist" }.to_json
    end
  end

  post "users/login" do
    user = User.find_by(email:params[:email])
  
    if user && user.authenticate(params[:password])
      user_data = {
          id: user.id,
          email: user.email
        }
      user_data.to_json
    else
      status 403
      { errors: "User doesn't exist" }.to_json
    end
  end

  patch "/users/:id" do
    user = User.find(params[:id])
    user.update(
      username:params[:username]
      )
    user_data = {
      id: user.id,
      username: user.username,
      email: user.email
    }
  user_data.to_json
  end
end
