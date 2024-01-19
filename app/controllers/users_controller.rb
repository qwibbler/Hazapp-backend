class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show
    render html: '<h1>No Maslas</h1>'.html_safe if @user.maslas.count.zero?

    @maslas = @user.maslas.includes(:user, :more_infos)
    @more_cols = @user.more_infos.distinct.pluck('info') || []

    @limit_answer = 55
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
