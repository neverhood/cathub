class Users::RegistrationsController < Devise::RegistrationsController

  private

  def resource_params
    params.require(:user).permit %i(email password password_confirmation)
  end
end
