class ProfilesController < ApplicationController

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def create
    @enroll = Enroll.find(current_client.id)
    @profile = Profile.new(params_profile)
    @profile.enroll_id = @enroll.id 
    @profile.save
    redirect_to @profile
  end

  #def edit
    #@profile = Profile.find(params[:id])
  #end

  #def update
    #@profile_params = params.require(:profile)
                            #.permit(:name, :address)
    #@profile = Profile.find_by(id: params[:id])
    #if @profile.update(@profile_params)
      #redirect_to @profile
    #else
      #render :edit
    #end
  #end
  private

  def params_profile
    params.require(:profile).permit(:name, :address)
  end

  
end