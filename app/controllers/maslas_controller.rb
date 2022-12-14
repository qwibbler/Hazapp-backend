class MaslasController < ApplicationController
  before_action :set_masla, only: %i[ show edit update destroy ]

  # GET /maslas or /maslas.json
  def index
    @maslas = Masla.all
    @table = premasla_pivot_table(PreMasla.all.includes(:masla))
  end

  # GET /maslas/1 or /maslas/1.json
  def show
  end

  # GET /maslas/new
  # def new
  #   @masla = Masla.new
  # end

  # GET /maslas/1/edit
  def edit
  end

  # POST /maslas or /maslas.json
  def create
    # TODO: params[:entries]
    @masla = Masla.new(masla_params)

    params[:entries].each do |entry|
      p
      p entry
      p
    end

    respond_to do |format|
      if @masla.save
        params[:others].each do |other|
          PreMasla.create(masla: @masla, premasla: other[0], value: other[1]) unless other[1].blank? || other[1].nil?
        end
        format.html { redirect_to masla_url(@masla), notice: "Masla was successfully created." }
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
        format.html { redirect_to masla_url(@masla), notice: "Masla was successfully updated." }
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
      format.html { redirect_to maslas_url, notice: "Masla was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_masla
      @masla = Masla.find(params[:id])
    end

    # TODO: Unpermitted parameters: :preMaslaValues
    # Only allow a list of trusted parameters through.
    def masla_params
      params.require(:masla).permit(:uid, :typeOfInput, :typeOfMasla, :answerUrdu, :answerEnglish, entries: [:startTime, :endTime])
    end
end
