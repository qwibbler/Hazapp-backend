class Users::SessionsController < Devise::SessionsController
  respond_to :json, :html

  private

  def respond_with(_resource, _opts = {})
    respond_to do |format|
      format.html do
        render :new
      end
      format.json do
        current_user ? log_in_success : log_in_failure
      end
    end
  end

  def log_in_success
    render json: { message: "Logged: #{current_user.id}" }, status: :ok
  end

  def log_in_failure
    render json: { message: 'Not logged in' }, status: :unauthorized
  end

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: 'Logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Logged out failure.' }, status: :unauthorized
  end
end
