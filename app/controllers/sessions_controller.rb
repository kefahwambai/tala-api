class SessionsController < ApplicationController

  def show
    if current_user
      @user = current_user
      render json: @user
    else
      render json: { user: nil }
    end
  end
   

  def index
      # set cookie
    cookies[:hello_world] ||= "Hello User"
    session[:hello_world] ||= "Hello World"
    render json: {cookies: cookies.to_hash}
  end
  
  def create
    user = User.find_by(email: params[:email]) 
    if user
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        render json: user
      else
        render json: { errors: ['Invalid email or password'] }, status: :unprocessable_entity
      end
    else
      render json: { errors: ['User not found'] }, status: :not_found
    end
  end
  
  def destroy
    logout!
    head :no_content
  end
end
  