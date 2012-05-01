Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/development.db')
class BlogPost < Sequel::Model
	plugin :json_serializer
end