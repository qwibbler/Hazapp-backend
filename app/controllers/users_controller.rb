class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show
    render html: '<h1>No Maslas</h1>'.html_safe if @user.maslas.count.zero?

    if @user.more_infos.count.zero?
      @maslas = @user.maslas
      @cols = @maslas.column_names
    else
      pivot_join_table = PivotJoinTable.new(@user.more_infos, 'info', 'masla_id', 'value', @user.maslas)
      @maslas = pivot_join_table.join_table.order(:id)
      @cols = pivot_join_table.all_columns
    end

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
