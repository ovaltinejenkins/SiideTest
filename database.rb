require 'sinatra'
require 'sinatra/sequel'

set :database, 'sqlite://db/development.db'

puts "blogposts table doesn't exist" if !database.table_exists?('blog_posts')

migration "create blogposts table" do
  database.create_table :blogposts do
    primary_key :id
	string		:title
    text        :body
    timestamp   :posted, :null => false
  end
 end
 
  migration "create blog_posts table and drop bad" do
  database.drop_table :blogposts
  database.create_table :blog_posts do
    primary_key :id
	string		:title
    text        :body
    timestamp   :posted, :null => false
  end
end