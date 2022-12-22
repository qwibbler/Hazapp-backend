class MaslasController < ApplicationController
  before_action :set_masla, only: %i[ show edit update destroy ]

  # GET /maslas or /maslas.json
  def index
    # Get all distinct premaslas to build columns
    cols = PreMasla.distinct.pluck(:premasla).sort
    # Quote the columns
    quotedCols = cols.map { |p| '"' + p + '"'}
    # extra_info Arel::Table
    premasla_tbl = PreMasla.arel_table
    # Arel::Table to use for querying
    tbl = Arel::Table.new('ct')

    # SQL data type for the premasla.premasla column
    premasla_sql_type = PreMasla.columns.find {|c| c.name == 'premasla' }&.sql_type

    # Part 1 of crosstab
    qry_txt = premasla_tbl.project(
      premasla_tbl[:masla_id],
      premasla_tbl[:premasla],
      premasla_tbl[:value]
    )
    # Part 2 of the crosstab
    cats =  premasla_tbl.project(premasla_tbl[:premasla]).distinct

    # construct the ct portion of the crosstab query
    ct = Arel::Nodes::NamedFunction.new('ct',[
      Arel::Nodes::TableAlias.new(Arel.sql('masla_id'), Arel.sql('bigint')),
      *quotedCols.map {|name|  Arel::Nodes::TableAlias.new(Arel.sql(name), Arel.sql(premasla_sql_type))}
    ])

    # build the crosstab(...) AS ct(...) statement
    crosstab = Arel::Nodes::As.new(
      Arel::Nodes::NamedFunction.new('crosstab', [Arel.sql("'#{qry_txt.to_sql}'"),
        Arel.sql("'#{cats.to_sql}'")]),
      ct
    )

    # final query construction
    q = tbl.project(tbl[Arel.star]).from(crosstab)
    # @try = ActiveRecord::Base.connection.execute(q.to_sql)

    sub = Arel::Table.new('subq')
    sub_q = Arel::Nodes::As.new(q, Arel.sql(sub.name))

    @out = Masla
    .joins(Arel::Nodes::OuterJoin.new(sub_q, Arel::Nodes::On.new(Masla.arel_table[:id].eq(sub[:masla_id]))))
    .select(Masla.arel_table[Arel.star], *cols.map {|c| sub[c.intern]}).order(:id)

    @cols = Masla.column_names + cols

    # "SELECT
    #   \"maslas\".*
    # FROM
    #   \"maslas\"
    # LEFT OUTER JOIN (
    #   SELECT
    #     \"ct\".*
    #   FROM
    #     crosstab(
    #       'SELECT
    #         \"pre_maslas\".\"masla_id\",
    #         \"pre_maslas\".\"premasla\",
    #         \"pre_maslas\".\"value\"
    #       FROM
    #         \"pre_maslas\"',
    #       'SELECT DISTINCT
    #         \"pre_maslas\".\"premasla\"
    #       FROM
    #         \"pre_maslas\"')
    #       AS
    #         ct(masla_id bigint,
    #           \"aadatHaiz\" character varying,
    #           \"aadatNifas\" character varying,
    #           \"aadatTuhr\" character varying,
    #           \"birthTime\" character varying,
    #           \"isMawjoodaFasid\" character varying,
    #           \"mawjoodahTuhr\" character varying,
    #           \"mustabeenUlKhilqat\" character varying,
    #           \"pregStartTime\" character varying))
    #   AS
    #     subq
    #   ON
    #     \"maslas\".\"id\" = \"subq\".\"masla_id\""

    @maslas = Masla.all
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

    # Only allow a list of trusted parameters through.
    def masla_params
      params.require(:masla).permit(:uid, :typeOfInput, :typeOfMasla, :answerUrdu, :answerEnglish, entries: [:startTime, :endTime])
    end
end
