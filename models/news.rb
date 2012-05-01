DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://db/sinatra.sqlite')
class News < Sequel::Model
#
# This is the model for the authors and is backed by the :authors table in the
# database. 
#
# Create the Author model. 
class Author < Sequel::Model 
    many_to_many :books
end

#
# This is the model for the book and is backed by the :book table in the
# database. 
#
# Create the Book model. 
class Book < Sequel::Model 
    many_to_many :authors
end
end