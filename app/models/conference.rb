class Conference
  include DataMapper::Resource

  property :id, Serial
  property :number, Integer
  property :pin, Integer
  property :description, String
end
