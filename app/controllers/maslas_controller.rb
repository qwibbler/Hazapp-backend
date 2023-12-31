require './app/models/pivot_join_table'
class MaslasController < ApplicationController
  before_action :set_masla, only: %i[show edit update destroy]

  # GET /maslas or /maslas.json
  def index
    Rails.logger.debug '==============='
    Rails.logger.debug "current_user"
    Rails.logger.debug current_user
    Rails.logger.debug '==============='
    render html: '<h1>No Maslas</h1>'.html_safe if Masla.count.zero?
    if MoreInfo.count.zero?
      @maslas = Masla.all
      @cols = Masla.column_names
    else
      pivot_join_table = PivotJoinTable.new(MoreInfo, 'info', 'masla_id', 'value', Masla)
      @maslas = pivot_join_table.join_table.order(:id)
      @cols = pivot_join_table.all_columns
    end

    @limit_entries = 1
    @limit_answer = 55
  end

  # GET /maslas/1 or /maslas/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @masla.to_json(include: :more_infos) }
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
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1], '00bd528dde1bacff485ccbf948202cc5c60264573308576d188bfd41aafbfe1985394ce4396deb8d2238c4b304e3ea467565906b73f04bf77e93b50951a0aa5b')
    Rails.logger.debug jwt_payload
    Rails.logger.debug '==========='

    current_user = User.find(jwt_payload.first['sub'])

    @masla = Masla.new(masla_params)
    @masla.user = current_user



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

  # Use callbacks to share common setup or constraints between actions.
  def set_masla
    @masla = Masla.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def masla_params
    params.require(:masla).permit(:uid, :typeOfInput, :typeOfMasla, :answerUrdu, :answerEnglish,
                                  entries: %i[startTime endTime])
  end
end
