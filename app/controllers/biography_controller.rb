class BiographyController < ApplicationController

	def index
		@user = User.find_by_username(params[:username])
	end

	def new
		@bio= current_user.bio.build
	end


	def show
     @bio = User.find_by_username(params[:id])
	end

  def edit
  end

	def create
    @bio = current_user.biography.build(bio_params)

    respond_to do |format|
      if @bio.save
        format.html { redirect_to biography_path, notice: 'bio was successfully created.' }
        format.json { render :show, status: :created, location: @bio }
        format.js
      else
        format.html { render :new }
        format.json { render json: @bio.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /biography/1
  # PATCH/PUT /biography/1.json
  def update
    respond_to do |format|
      if @bio.update(bio_params)
        format.html { redirect_to biography_path, notice: 'bio was successfully updated.' }
        format.json { render :index, status: :ok, location: @biography }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @bio.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /biography/1
  # DELETE /biography/1.json
  def destroy
    @bio.destroy
    respond_to do |format|
      format.html { redirect_to biography_url, notice: 'bio was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bio
      @bio = bio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bio_params
      params.require(:bio).permit(:content, :image)
    end

end
