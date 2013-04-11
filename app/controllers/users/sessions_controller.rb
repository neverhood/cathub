class Users::SessionsController < Devise::SessionsController
  def create
  end

  private

  def resource_params
    params.require(:user).permit %i(email password)
  end
end
