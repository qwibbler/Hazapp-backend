class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  def index
    @users = User.all.paginate(page: params[:page], per_page: 100).order(created_at: :desc)
  end

  def show
    render 'shared/noMasla' if !@user.personal_apper? && @user.maslas.count.zero?

    @maslas = @user.maslas.paginate(page: params[:page], per_page: 100).includes(:user,
                                                                                 :more_infos).order(created_at: :desc)
    @more_cols = @user.more_infos.distinct.pluck('info') || []
    @count = @user.maslas.count

    @limit_answer = 55
  end

  def update
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to @user, notice: I18n.t('user_successfully_updated') }
        format.json do
          @message = "Display name updated successfully to '#{@user.displayname}'"
          render 'shared/user_details', status: :ok
        end
      end
    else
      render json: { message: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password, :user_role, :user_role_id, :masla_id, :displayname)
  end
end
