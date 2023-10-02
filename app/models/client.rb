class Client < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :loans
    has_one_attached :avatar   
    
end
