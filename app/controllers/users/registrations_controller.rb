class Users::RegistrationsController < Devise::RegistrationsController

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    if @user.set_own_password?
      super
    else
      if @user.update(passwordless_resource_params)
        sign_in @user, bypass: true
        redirect_to after_update_path_for(@user), notice: I18n.t('flash.users.registrations.update.notice')
      else
        flash.now[:alert] = I18n.t('flash.users.registrations.update.alert')
        render 'edit'
      end
    end
  end

  private

  def resource_params
    params.require(:user).permit [:email, :name, :password, :password_confirmation, :current_password]
  end

  def passwordless_resource_params
    params.require(:user).permit( [:email, :name, :password, :password_confirmation] )
  end
end
