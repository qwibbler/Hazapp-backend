require './app/models/pivot_join_table'
class MaslasController < ApplicationController
  before_action :set_masla, only: %i[show edit update destroy]

  # GET /maslas or /maslas.json
  def index
    render html: '<h1>No Maslas</h1>'.html_safe if Masla.count.zero?
    @maslas = Masla.includes(:user, :more_infos)
    @more_cols = MoreInfo.distinct.pluck('info') || []
    @limit_answer = 55
  end

  # GET /maslas/1 or /maslas/1.json
  def show
    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /maslas/new
  # def new
  #   @masla = Masla.new
  # end

  # GET /maslas/1/edit
  def edit; end

  # POST /maslas or /maslas.json
  def create
    @masla = Masla.new(masla_params)
    @masla.user = find_current_user

    respond_to do |format|
      if @masla.save
        params[:others].each do |other|
          MoreInfo.create(masla: @masla, info: other[0], value: other[1]) unless other[1].blank? || other[1].nil?
        end
        format.html { redirect_to masla_url(@masla), notice: I18n.t('masla_successfully_created') }
        format.json { render :show, status: :created, location: @masla }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @masla.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maslas/1 or /maslas/1.json
  def update
    respond_to do |format|
      if @masla.update(masla_params)
        format.html { redirect_to masla_url(@masla), notice: I18n.t('masla_successfully_updated') }
        format.json { render :show, status: :ok, location: @masla }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @masla.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maslas/1 or /maslas/1.json
  def destroy
    @masla.destroy

    respond_to do |format|
      format.html { redirect_to maslas_url, notice: I18n.t('masla_successfully_deleted') }
      format.json { head :no_content }
    end
  end

  private

  def find_current_user
    token = request.headers['Authorization']
    return unless !token.nil? && token != ''

    begin
      jwt_payload = JWT.decode(token.split[1],
                               Rails.application.credentials.DEVISE_JWT_SECRET_KEY)
      User.find(jwt_payload.first['sub'])
    rescue StandardError
      nil
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_masla
    @masla = Masla.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format|
      format.html { render file: Rails.public_path.join('404.html').to_s, layout: false, status: :not_found }
      format.json { render json: { error: e.message }, status: :not_found }
    end
  end

  # Only allow a list of trusted parameters through.
  def masla_params
    params.require(:masla).permit(:typeOfInput, :typeOfMasla, :answerUrdu, :answerEnglish,
                                  entries: %i[startTime endTime value type])
  end
end
