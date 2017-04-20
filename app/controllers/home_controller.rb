class HomeController < ApplicationController

  def index
  	if user_signed_in?
  		redirect_to posts_path
  	else
  	   render :layout => false
  	end
  end

end
