class Client < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :loans
    has_one_attached :image

      ddef image_url
      if image.attached?
        Rails.application.routes.url_helpers.url_for(image.variant(resize: '100x100'), host: 'https://topacash.onrender.com')
      else
        nil
      end
    end  
      
    
end
