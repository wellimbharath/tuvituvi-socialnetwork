class DreamsController < ApplicationController
   before_filter :authenticate_user!
   respond_to :html, :js

   def index
  @dreams = current_user.dreams.all
	@incomplete_dreams = current_user.dreams.where(complete: false)
	@achieved_dreams =current_user.dreams.where(complete: true)
   end

   def new
   	@dream = current_user.dreams.build
   end

  def create
  	@dream = current_user.dreams.build(dream_params)
  	 respond_to do |format|
      if @dream.save
        format.html { redirect_to :back, notice: 'Dream was successfully created.' }
        format.json { render :show, status: :created, location: @dream }
        format.js
      else
        format.html { redirect_to wizard_path, notice: 'Unable to create dream' }
        format.json { render json: @dream.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

 def update
 	@dream = Dream.find_by_id(params[:id])
    respond_to do |format|
      if @dream.update_attributes!(dream_params)
        format.html { redirect_to dreams_path, notice: 'dream was successfully updated.' }
        format.json { render :index, status: :ok, location: @dreams }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @dream.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /dreams/1
  # DELETE /dreams/1.json
  def destroy
  @dream = Dream.find_by_id(params[:id])
    @dream.destroy
    respond_to do |format|
      format.html { redirect_to dreams_url, notice: 'dream was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

private

 def dream_params
  params.require(:dream).permit(:dream, :complete)
 end
end
