require './app/models/pivot_join_table'
class MaslasController < ApplicationController
  before_action :set_masla, only: %i[show edit update destroy]

  # GET /maslas or /maslas.json
  def index
    pivot_join_table = PivotJoinTable.new(PreMasla, 'premasla', 'masla_id', 'value', Masla)

    @maslas = pivot_join_table.join_table.order(:id)
    @cols = pivot_join_table.all_columns

    @limit_entries = 1
    @limit_answer = 55
  end

  # GET /maslas/1 or /maslas/1.json
  def show; end

  # GET /maslas/new
  # def new
  #   @masla = Masla.new
  # end

  # GET /maslas/1/edit
  def edit; end

  # POST /maslas or /maslas.json
  def create
    @masla = Masla.new(masla_params)

    respond_to do |format|
      if @masla.save
        params[:others].each do |other|
          PreMasla.create(masla: @masla, premasla: other[0], value: other[1]) unless other[1].blank? || other[1].nil?
        end
        format.html { redirect_to masla_url(@masla), notice: 'Masla was successfully created.' }
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
        format.html { redirect_to masla_url(@masla), notice: 'Masla was successfully updated.' }
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
      format.html { redirect_to maslas_url, notice: 'Masla was successfully destroyed.' }
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
