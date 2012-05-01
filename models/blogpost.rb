require 'sequel'
require 'json'
class BlogPost < Sequel::Model
	plugin :json_serializer
end