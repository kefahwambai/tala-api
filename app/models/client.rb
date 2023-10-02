class Client < ApplicationRecord
  
  has_many :loans
  has_one_attached :avatar
  has_many_attached :images

  validates :name, presence: true, uniqueness: true
  validates :avatar, attached: true, dimension: { width: { min: 800, max: 2400 } },
    content_type: [:png, :jpg, :jpeg], size: { less_than: 100.kilobytes , message: 'is not given between size' }

  validates :images, attached: true, limit: { min: 1, max: 3 }, content_type: [:png, :jpg, :jpeg, :mp3]


  def thumbnail
    if avatar.attached?
      avatar.variant(resize: '100x100').processed
    else
      nil
    end
  end
end
