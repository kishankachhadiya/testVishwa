class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:create,:update,:changed_password,:change_password]
  # before_action :configure_account_update_params, only: [:update]

  def update
    if resource.update_without_password(account_update_params)
      redirect_to show_user_home_path(current_user.id)
    else
      render 'edit'
    end
  end
  def changed_password
    self.resource = current_user
    puts "::::::::::::#{resource.inspect}"
    if resource.update_with_password(account_update_params)
      redirect_to homes_path
    else
      puts "----------#{resource.errors.full_messages}"
      render 'change_password'
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end



  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:firstname,:lastname,:usertype,:email,:password)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :current_password, :password, :password_confirmation,:firstname,:lastname)
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.usertype == "buyer"
      buyers_homes_path
    else
      sellers_homes_path
    end
  end
end
