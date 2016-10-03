# module DevisePermittedParameters
#   extend ActiveSupport::Concern

#   included do
#     before_action :configure_permitted_parameters
#   end

#   protected

#   def configure_permitted_parameters
#     devise_parameter_sanitizer.for(:sign_up) << :name
#     devise_parameter_sanitizer.for(:account_update) << :name
#   end

# end

# DeviseController.send :include, DevisePermittedParameters


module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) << :name
    # devise_parameter_sanitizer.for(:account_update) << :name

    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
	    user_params.permit({ roles: [] }, :email, :name, :password, :password_confirmation)
	  end
	devise_parameter_sanitizer.permit(:sign_in) do |user_params|
	    user_params.permit({ roles: [] }, :email, :name, :password, :password_confirmation)
	  end
	devise_parameter_sanitizer.permit(:account_update) do |user_params|
	    user_params.permit({ roles: [] }, :email, :name, :password, :password_confirmation)
	end
	

  end

end

DeviseController.send :include, DevisePermittedParameters

