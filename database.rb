require 'sinatra'
require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/development.db')

Sequel.migration do
  create_table :blogposts do
    primary_key :id
	string		:title
    text        :body
    timestamp   :posted, :null => false
  end
 end
 
Sequel.migration do
  drop_table :blogposts
  create_table :blog_posts do
    primary_key :id
	string		:title
    text        :body
    timestamp   :posted, :null => false
  end
end