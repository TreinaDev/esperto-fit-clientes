class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
  end

  def new
    return redirect_to root_path if current_client.enroll.nil?
    @profile = Profile.new
  end

  def create
    @enroll = Enroll.find(current_client.id)
    @profile = Profile.new(params_profile)
    if @profile.save
      redirect_to @profile, notice: t('.successfully')
    else
      render :new
    end
  end

  # def edit
  # @profile = Profile.find(params[:id])
  # end

  # def update
  # @profile_params = params.require(:profile)
  # .permit(:name, :address)
  # @profile = Profile.find_by(id: params[:id])
  # if @profile.update(@profile_params)
  # redirect_to @profile
  # else
  # render :edit
  # end
  # end
  private

  def params_profile
    params.require(:profile).permit(:name, :address).merge(enroll_id: @enroll.id)
  end
end
