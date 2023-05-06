class RegistrationsController < Devise::RegistrationsController

    protected
    def update_resource(resource, params)
        resource.update_with_password(params)
    end

    def update
        super
        if account_update_params[:avatar].present?
            resource.avatar.attach(account_update_params[:avatar])
        end
    end
end
