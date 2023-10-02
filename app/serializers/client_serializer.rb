class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url
  has_many :loans

  def avatar_url
    if object.avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.avatar, only_path: true)
    else
      nil
    end
  end
end
