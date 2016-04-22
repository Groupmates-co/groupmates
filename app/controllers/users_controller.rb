class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users/:id.:format
  def show
    # authorize! :read, @user
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end

  #Experimental 
  def update_picture
    respond_to do |format|
      @user.profile_picture = nil
      @user.save
      format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
      format.json { head :no_content }
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
end