require "application_responder"

class ApplicationController < ActionController::API

  include ActionController::Cookies
  include ActionController::MimeResponds
  include ActionController::RequestForgeryProtection
 
  respond_to :html
  protect_from_forgery with: :exception
  before_action :snake_case_params, :attach_authenticity_token

  self.responder = ApplicationResponder

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
    @current_user = nil
  end

  def require_logged_in
    unless current_user
      render json: { message: 'Unauthorized' }, status: :unauthorized 
    end
  end

  private
  def snake_case_params
    params.deep_transform_keys!(&:underscore)
  end

  def attach_authenticity_token
    headers['X-CSRF-Token'] = masked_authenticity_token(session)
  end
  
  def invalid_authenticity_token
    render json: { message: 'Invalid authenticity token' }, 
      status: :unprocessable_entity
  end
  
end