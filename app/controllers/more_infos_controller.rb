class MoreInfosController < ApplicationController
  before_action :set_more_info, only: %i[show edit update destroy]

  # GET /more_infos or /more_infos.json
  # def index
  #   @more_infos = MoreInfo.all
  # end

  # GET /more_infos/1 or /more_infos/1.json
  # def show; end

  # GET /more_infos/new
  # def new
  #   @more_info = MoreInfo.new
  # end

  # GET /more_infos/1/edit
  # def edit; end

  # POST /more_infos or /more_infos.json
  def create
    @more_info = MoreInfo.new(more_info_params)

    respond_to do |format|
      if @more_info.save
        format.html { redirect_to more_info_url(@more_info), notice: 'More info was successfully created.' }
        format.json { render :show, status: :created, location: @more_info }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @more_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /more_infos/1 or /more_infos/1.json
  def update
    respond_to do |format|
      if @more_info.update(more_info_params)
        format.html { redirect_to more_info_url(@more_info), notice: 'More info was successfully updated.' }
        format.json { render :show, status: :ok, location: @more_info }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @more_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /more_infos/1 or /more_infos/1.json
  def destroy
    @more_info.destroy

    respond_to do |format|
      format.html { redirect_to more_infos_url, notice: 'More info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_more_info
    @more_info = MoreInfo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def more_info_params
    params.fetch(:more_info, {})
  end
end
