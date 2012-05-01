require 'sinatra'
require 'sinatra/sequel'
require_relative 'models/news'
# see:

unless DB.table_exists? :authors
	DB.create_table :authors do
	  primary_key :id
	  String :name
	end
end
authors = DB[:authors]
# access the database within the context of an HTTP request
get '/foos/new' do
	authors.insert(:name => 'dick waters')
end

# or, using the model
delete '/foos/:id' do
  @foo = Foo[params[:id]]
  @foo.delete
end

# access the database within the context of an HTTP request
get '/author/:id' do
  @foo = authors.filter(:id => params[:id]).first
	haml :index
end

# or, using the model
delete '/foos/:id' do
  @foo = Foo[params[:id]]
  @foo.delete
end