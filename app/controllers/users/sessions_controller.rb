class Users::SessionsController < Devise::SessionsController
  respond_to :json, :html
  # clear_respond_to if request.format == 'json'

  # def new
  #   Rails.logger.debug request.format
  #   # clear_respond_to if request.format == 'json'
  #   super
  #   # respond_to do |format|
  #   #   format.html { redirect_to new_user_session_path }
  #   #   format.json { super }
  #   # end
  # end

  private

  def respond_with(_resource, _opts = {})
    respond_to do |format|
      format.html { render :new }
      format.json { current_user ? log_in_success : log_in_failure }
    end
  end

  def log_in_success
    render json: { message: "Logged: #{current_user.id}" }, status: :ok
  end

  def log_in_failure
    render json: { message: 'Not logged in' }, status: :unauthorized
  end

  def respond_to_on_destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: I18n.t('successfully_signed_out') }
      format.json { current_user ? log_out_success : log_out_failure }
    end
  end

  def log_out_success
    render json: { message: 'Logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Logged out failure.' }, status: :unauthorized
  end
end
