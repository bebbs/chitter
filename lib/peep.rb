class Peep

  include DataMapper::Resource

  property :id, Serial
  property :content, Text
  property :created_at, DateTime

  belongs_to :user

  def self.get_all_in_order_of_creation
    all.sort{|a,b| b.created_at <=> a.created_at}
  end

end