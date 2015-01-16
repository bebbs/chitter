class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String, :unique => true
  property :username, String, :unique => true
  property :display_name, String
  property :password_digest, Text

end