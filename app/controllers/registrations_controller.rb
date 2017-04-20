class RegistrationsController  < Devise::RegistrationsController
 layout "update"

   def after_inactive_sign_up_path_for(resource_or_scope)
    session["user_return_to"] || root_path
  end
	
	protected

	def update_resource(resource, params)
    	resource.update_without_password(user_params)
  	end

	def after_sign_up_path_for(resource)
		'/update'
	end


end
