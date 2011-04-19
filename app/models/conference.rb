class Conference
  include DataMapper::Resource

  property :id, Serial
  property :description, String
end
