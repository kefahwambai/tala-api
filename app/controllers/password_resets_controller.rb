class PasswordResetsController < ApplicationController
    def create
        user = User.find_by(email: params[:email])
        if user
        user.generate_password_reset_token
        UserMailer.password_reset_email(user).deliver_now # Assuming you have UserMailer set up
        render json: { message: 'Password reset email sent' }, status: :ok
        else
        render json: { error: 'User not found' }, status: :not_found
        end
    end

    def edit
        @user = User.find_by(password_reset_token: params[:token])

        # Check if the token is valid and not expired
        if @user && @user.password_reset_sent_at > 2.hours.ago
        # Render the user data, or just the token if needed
        render json: { token: @user.password_reset_token }
        else
        # Handle the error by returning an error response
        render json: { error: 'Password reset token has expired or is invalid.' }, status: :unprocessable_entity
        end
    end

    def update
        @user = User.find_by(password_reset_token: params[:id])
        if @user && @user.password_reset_sent_at > 2.hours.ago
        if @user.update(user_params)
            # Clear the password reset token and timestamp
            @user.update(password_reset_token: nil, password_reset_sent_at: nil)
            render json: @user, status: :ok
        else
            render json: { error: 'Password reset failed' }, status: :unprocessable_entity
        end
        else
        render json: { error: 'Password reset token has expired' }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.permit(:password, :password_confirmation)
    end
end
