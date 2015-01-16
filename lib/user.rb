class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String, :unique => true
  property :username, String, :unique => true
  property :display_name, String
  property :password_digest, Text

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end