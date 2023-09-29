class User < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :email, uniqueness: true, length: { in: 3..255 }, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
    validates :session_token, presence: true, uniqueness: true
    validates :password, length: { in: 6..255 }, allow_nil: true    
  
    has_many :clients
    has_secure_password
    before_validation :ensure_session_token, :set_name
  
    def self.find_user_by(email, password)
        user = User.find_by(email: email)
        if user && user&.authenticate(password)
          return user
        end
        nil
    end
  
    def reset_session_token!        
        new_token = generate_unique_session_token
        update!(session_token: new_token)        
        new_token
    end

    def generate_password_reset_token
      self.password_reset_token = SecureRandom.urlsafe_base64
      self.password_reset_sent_at = Time.zone.now
      save!
  
      UserMailer.password_reset_email(self).deliver_now
    end

      
    private
  
    def generate_unique_session_token  
      loop do
        token = SecureRandom.base64
        break token unless User.exists?(session_token: token)
      end
    end
  
    def ensure_session_token  
      self.session_token ||= generate_unique_session_token
    end
  
    def set_name
      self.name = "user#{SecureRandom.random_number(100000000)}" if self.name == ""
    end   
  
end
  