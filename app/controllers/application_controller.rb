class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  #posts routes

  get "/posts" do
    posts = Post.all.limit(10)
    updated_posts = posts.map do |post|
      {
        id: post.id,
        title: post.title,
        content: post.content,
        likes: post.likes || 0
      }
    end
    updated_posts.to_json
  end

  post "/posts" do
    post = Post.create(
      title:params[:title],
      content:params[:content]
     )
    post.to_json
  end

  get "/posts/:id" do
    post = Post.find(params[:id])
      updated_post = {
          id: post.id,
          title: post.title,
          content: post.content
        }
      updated_post.to_json
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
    post = Post.find(params[:id])
    post.destroy
  end
end
