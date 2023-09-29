class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :message
end
