require 'sinatra'
require 'sequel'
require 'rubygems'
require 'json'

require_relative 'models/blogpost.rb'
Sequel.extension :pagination

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/development.db')

DB.create_table? :blog_posts do
		primary_key :id
	String		:title
		String				:body
		timestamp	 :posted, :null => false 
end

get '/all' do
	redirect '/'
end

get '/index' do
	redirect '/'
end

 
get '/' do
	after = params[:after]
	if after.nil?
		page = params[:page].to_i
		page = 1 if page.nil? or page == 0
		@blogposts = BlogPost.order(:posted.desc).paginate(page,10)
		
		if page == 1
			haml :"blogposts/index"
		else
			haml :"blogposts/more", :layout => false
		end
	else
		t = Time.parse(after)
		@blogposts = BlogPost.filter('posted > ? ', t).order(:posted.desc)
		haml :"blogposts/more", :layout => false
	end
end

get '/new' do
	haml :"blogposts/new"
end

get '/:id/edit' do
	@blogpost = BlogPost[params[:id]]
	unless @blogpost.nil?
		haml :"blogposts/edit"
	else
		halt 404
	end
end

put '/:id' do	
	p = BlogPost[params[:id]]

	unless @blogpost.nil?
		p.title = params[:title]	
		p.body = params[:body]
		p.save	
		redirect '/'	
	else
		halt 404
	end

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

	unless @blogpost.nil?
		haml :"blogposts/delete"
	else
		halt 404
	end
end

delete '/:id' do
	p = BlogPost[params[:id]]
	p.delete	
	redirect '/'	
end

get '/:id' do
	@blogpost = BlogPost[params[:id]]
	unless @blogpost.nil?
		haml :"blogposts/show"
	else
		halt 404
	end
end
