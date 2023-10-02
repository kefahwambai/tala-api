class ClientSerializer < ActiveModel::Serializer
    
  attributes :id, :name, :avatar_url
  has_many :loans
  
end
