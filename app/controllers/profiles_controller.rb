class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
      @profile = current_user.profile
  end

  def edit
      if current_user.profile.present?
        @profile = current_user.profile
      else
        @profile = current_user.build_profile
      end
      # has_oneで関係づけている場合は所属元.build_modelの単数形になる
      # @profile = current_user.profile || current_user.build_profile
      # 上記の省略形！userにprofile情報あれば左の定義、nilだったら右の内容が定義
      # @profile = current_user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
      # assign_attributesで上で作った箱に値を入れている
    if @profile.save
      redirect_to profile_path, notice: 'プロフィールを更新'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  private def profile_params
    params.require(:profile).permit(
      :nickname,
      :introduction,
      :gender,
      :birthday,
      :subscribed,
      :avatar
    )
  end
end