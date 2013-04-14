class Users::OmniauthCallbacksController < ApplicationController
  def facebook
  end

  def vkontakte
    user = User.find_for_vkontakte_oauth request.env["omniauth.auth"]

    if user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Vkontakte"
      sign_in_and_redirect user, event: :authentication
    else
      redirect_to root_path, alert: I18n.t('auth.omniauth_failure')
    end
  end

  def facebook
    user = User.find_for_facebook_oauth request.env["omniauth.auth"]
    if user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Facebook"
      sign_in_and_redirect user, event: :authentication
    else
      redirect_to root_path, alert: I18n.t('auth.omniauth_failure')
    end
  end
end
