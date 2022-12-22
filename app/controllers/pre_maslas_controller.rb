class PreMaslasController < ApplicationController
  before_action :set_pre_masla, only: %i[show edit update destroy]

  # GET /pre_maslas or /pre_maslas.json
  def index
    @pre_maslas = PreMasla.all
  end

  # GET /pre_maslas/1 or /pre_maslas/1.json
  def show; end

  # GET /pre_maslas/new
  def new
    @pre_masla = PreMasla.new
  end

  # GET /pre_maslas/1/edit
  def edit; end

  # POST /pre_maslas or /pre_maslas.json
  def create
    @pre_masla = PreMasla.new(pre_masla_params)

    respond_to do |format|
      if @pre_masla.save
        format.html { redirect_to pre_masla_url(@pre_masla), notice: 'Pre masla was successfully created.' }
        format.json { render :show, status: :created, location: @pre_masla }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pre_masla.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pre_maslas/1 or /pre_maslas/1.json
  def update
    respond_to do |format|
      if @pre_masla.update(pre_masla_params)
        format.html { redirect_to pre_masla_url(@pre_masla), notice: 'Pre masla was successfully updated.' }
        format.json { render :show, status: :ok, location: @pre_masla }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pre_masla.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pre_maslas/1 or /pre_maslas/1.json
  def destroy
    @pre_masla.destroy

    respond_to do |format|
      format.html { redirect_to pre_maslas_url, notice: 'Pre masla was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pre_masla
    @pre_masla = PreMasla.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def pre_masla_params
    # params.fetch(:pre_masla, {})
    params.permit(:masla_id, :premasla, :value)
  end
end
