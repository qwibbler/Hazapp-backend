class PivotJoinTable
  def initialize(to_pivot_table, to_pivot_column, to_pivot_index, pivot_value, to_join_table)
    @to_pivot_table = to_pivot_table
    @to_pivot_column = to_pivot_column
    @to_pivot_index = to_pivot_index
    @pivot_value = pivot_value
    @to_join_table = to_join_table
  end

  def new_columns
    # Get all distinct premaslas to build columns
    @to_pivot_table.distinct.pluck(@to_pivot_column).sort
  end

  def quoted_columns
    # Quote the columns for postgresql
    new_columns.map { |p| "\"#{p}\"" }
  end

  def all_columns
    @to_join_table.column_names + new_columns
  end

  def pivot_table
    # extra_info Arel::Table
    to_pivot_table_arel = @to_pivot_table.arel_table
    # Arel::Table to use for querying
    tbl = Arel::Table.new('ct')

    # SQL data type for the premasla.premasla column
    to_pivot_table_sql_type = @to_pivot_table.columns.find { |c| c.name == @to_pivot_column }&.sql_type

    # Part 1 of crosstab
    qry_txt = to_pivot_table_arel.project(
      to_pivot_table_arel[@to_pivot_index],
      to_pivot_table_arel[@to_pivot_column],
      to_pivot_table_arel[@pivot_value]
    )
    # Part 2 of the crosstab
    cats = to_pivot_table_arel.project(to_pivot_table_arel[@to_pivot_column]).distinct

    # construct the ct portion of the crosstab query
    ct = Arel::Nodes::NamedFunction
      .new('ct', [Arel::Nodes::TableAlias.new(Arel.sql(@to_pivot_index), Arel.sql('bigint')), *quoted_columns.map do |name|
                                                                                                Arel::Nodes::TableAlias.new(Arel.sql(name), Arel.sql(to_pivot_table_sql_type))
                                                                                              end])

    # build the crosstab(...) AS ct(...) statement
    crosstab = Arel::Nodes::As.new(
      Arel::Nodes::NamedFunction.new('crosstab', [Arel.sql("'#{qry_txt.to_sql}'"),
                                                  Arel.sql("'#{cats.to_sql}'")]),
      ct
    )
    # final query construction
    tbl.project(tbl[Arel.star]).from(crosstab)
  end

  def join_table
    sub = Arel::Table.new('subq')
    sub_q = Arel::Nodes::As.new(pivot_table, Arel.sql(sub.name))

    @to_join_table
      .joins(Arel::Nodes::OuterJoin.new(sub_q,
                                        Arel::Nodes::On.new(@to_join_table.arel_table[:id].eq(sub[@to_pivot_index]))))
      .select(@to_join_table.arel_table[Arel.star], *new_columns.map { |c| sub[c.intern] })
    # @cols = to_join_table.column_names + cols
  end
end
