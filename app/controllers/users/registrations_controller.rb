class Users::RegistrationsController < Devise::RegistrationsController

  private

  def resource_params
    params.require(:user).permit %i(email name password password_confirmation)
  end
end
