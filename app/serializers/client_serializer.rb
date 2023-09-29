class ClientSerializer < ActiveModel::Serializer
    
  attributes :id, :name, :image_url
  has_many :loans
  
end
