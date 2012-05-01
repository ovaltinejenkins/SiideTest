require 'sinatra'
require 'sequel'
require 'rubygems'
require 'json'

require_relative 'models/blogpost.rb'	

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/development.db')

DB.create_table? :blog_posts do
    primary_key :id
	string		:title
    text        :body
    timestamp   :posted, :null => false
end

get '/all' do
	@blogposts = BlogPost.order(:posted.desc)
	haml :"blogposts/list"
end
 
get '/initial' do
	@blogposts = BlogPost.order(:posted.desc).limit(10)
	maxId = @blogposts.max(:id)
	minId = @blogposts.min(:id)
	morePages = !@blogposts.filter('id < ?',minId).count.zero?
	{:data => (haml :"blogposts/list", :layout => false), :morePages => morePages, :maxId => maxId, :minId => minId, :content_type => 'application/json'}.to_json
end

post '/update' do
	puts params[:id]
	@blogposts = BlogPost.filter('id > ?',params[:id].to_i)
	puts @blogposts.count
	maxId = @blogposts.max(:id) ? @blogposts.max(:id) : params[:id]
	{:data => (haml :"blogposts/list", :layout => false), :maxId => maxId, :content_type => 'application/json'}.to_json
end

post '/page' do
	puts [params[:id]]
	@blogposts = BlogPost.filter('id < ?',params[:id].to_i).order(:posted.desc).limit(10)
	minId = @blogposts.min(:id)
	morePages = !@blogposts.filter('id < ?',minId).count.zero?
	puts morePages
	{:data => (haml :"blogposts/list", :layout => false), :morePages => morePages, :minId => minId, :content_type => 'application/json'}.to_json
end

get '/index' do
	haml :"blogposts/index"
end

get '/' do
	redirect '/index'
end

get '/new' do
	haml :"blogposts/new"
end

get '/:id/edit' do
	@blogpost = BlogPost[params[:id]]
	unless @blogpost.nil?
		haml :"blogposts/edit", :layout => false
	else
		"...no"
	end
end

put '/:id' do  
  p = BlogPost[params[:id]]
  p.title = params[:title]  
  p.body = params[:body]
  p.save  
  redirect '/'  
end  

post '/new' do
	p = BlogPost.new
	p.title = params[:title]
	p.body = params[:body]
	p. posted = Time.now
	p.save
	redirect '/'
end

# or, using the model
get '/:id/delete' do
	@blogpost = BlogPost[params[:id]]
	haml :"blogposts/delete", :layout => false
end


delete '/:id' do
  p = BlogPost[params[:id]]
  p.delete  
  redirect '/'  
end

get '/:id' do
	@blogpost = BlogPost[params[:id]]
	unless @blogpost.nil?

		haml :"blogposts/show", :layout => false
	else
		"No post found with that id."
	end
end
