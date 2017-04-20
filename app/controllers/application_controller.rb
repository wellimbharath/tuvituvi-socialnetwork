class ApplicationController < ActionController::Base
include PublicActivity::StoreController
protect_from_forgery with: :null_session
before_filter :authenticate_user!, except: [:show, :index, :terms, :about, :contact]
before_action :configure_permitted_parameters, if: :devise_controller?
protected
after_filter :store_location

def store_location
  return unless request.get?
  if (request.path != "login" &&
      request.path != "register" &&
      request.path != "/users/confirmation" &&
      request.path != "logout"
      )
    session["user_return_to"] = request.fullpath
  end
end

def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:terms, :username, :firstname, :lastname, :bio,:crop_x, :crop_y, :crop_w, :crop_h, :email, :password, :password_confirmation, :background, :remember_me, :avatar, :dob, :first_name, :last_name, :bio, :interest, :lastname) }
  devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me, ) }
  devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:background, :username, :firstname, :bio,:crop_x, :crop_y, :crop_w, :dream ,:crop_h, :lastname, :address,:avatar, :email, :password, :password_confirmation, :current_password) }
end

def create
  @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    redirect_to update_path, :notice => "Your almost there.. Fill in your details."
  else
    render "new"
  end
end

def show
  @user = User.find_by_username(params[:id])
end


private

def user_params
  params.require(:user).permit(:firstname, :crop_x, :crop_y, :crop_w, :crop_h, :lastname, :dob, :bio, :interest, :background, :avatar, :role)
end


def after_sign_in_path_for(resource)
  blacklist = [new_user_session_path, new_user_registration_path] # etc...
  last_url = session["user_return_to"]
  if blacklist.include?(last_url)
    root_path
  else
    last_url
  end
end

end
