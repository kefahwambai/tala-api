class ClientSerializer < ActiveModel::Serializer
    
  attributes :id, :name, :avatar
  has_many :loans
  
end
