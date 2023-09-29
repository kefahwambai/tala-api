class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phonenumber
end
