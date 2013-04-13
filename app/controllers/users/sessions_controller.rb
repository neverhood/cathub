class Users::SessionsController < Devise::SessionsController

  private

  def resource_params
    params.require(:user).permit %i(email password)
  end

end
