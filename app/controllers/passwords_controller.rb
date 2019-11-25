class PasswordsController < Devise::PasswordsController
  respond_to :json

  def create
    user = User.find_by('LOWER(email) = ?', params[:user][:email].downcase)
    if user
      user.send_reset_password_instructions
      render json: {}, status: 204
    else
      render json: {errors: {email: 'Email is not registered'}}, status: 406
    end
  end

  def update
    enc_token = Devise.token_generator.digest('user', :reset_password_token, user_params[:reset_password_token])
    user = User.find_by(reset_password_token: enc_token)
    if user && user.reset_password_period_valid?
      if user.reset_password(user_params[:password], user_params[:password_confirmation])
        sign_in(user)
      end
      render_resource(user)
    else
      render json: {status: 406, errors: {reset_password_token: "Invalid reset password token or it has expired"}}, status: 406
    end
  end

  private
  def user_params
    params.require(:user).permit(:reset_password_token, :password, :password_confirmation)
  end
end
