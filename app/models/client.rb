class Client < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :loans
    has_one_attached :image

    def image_url
        if image.attached?
            Rails.application.routes.url_helpers.url_for(image)
        else
           
            nil 
        end
    end
    
end
