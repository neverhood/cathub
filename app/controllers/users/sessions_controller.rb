class Users::SessionsController < Devise::SessionsController

  private

  def resource_params
    params.require(:user).permit [:email, :password]
  end

end
