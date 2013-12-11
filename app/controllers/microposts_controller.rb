class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
  	@micropost = current_user.microposts.build(micropost_params)
    respond_to do |format|
      if @micropost.save
        format.html { redirect_to root_path }
        format.js
        #redirect_to root_url 
      else
        format.html
        format.js
      end
    end
  end

  def destroy
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end