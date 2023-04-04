class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :avatar])
    end

    def after_sign_in_path_for(resource)
        pages_home_path
    end

    add_flash_types :success, :info, :warning, :danger

end