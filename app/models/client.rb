class Client < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :loans
  has_one_attached :avatar

  def avatar_url
    if avatar.attached?
      Rails.application.routes.url_helpers.url_for(avatar.variant(resize: '100x100', host: 'https://topacash.onrender.com'))
    else
      nil
    end
  end

  def thumbnail
    if avatar.attached?
      avatar.variant(resize: '100x100').processed
    else
      nil
    end
  end
end
