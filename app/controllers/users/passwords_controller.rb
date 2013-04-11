class Users::PasswordsController < Devise::PasswordsController

  private

  def resource_params
    params.require(:user).permit %i(email password password_confirmation reset_password_token)
  end
end
