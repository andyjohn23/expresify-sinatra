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

  delete '/posts/:id' do
    Post.get(params[:id]).destroy
  end
end
