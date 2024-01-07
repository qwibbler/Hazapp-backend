class PivotJoinTable
  def initialize(config = {})
    @to_pivot_table = config[:to_pivot_table] || MoreInfo
    @pivot_column = config[:to_pivot_column] || 'info'
    @pivot_index = config[:to_pivot_index] || 'masla_id'
    @pivot_value = config[:pivot_value] || 'value'
    @to_join_table = config[:to_join_table] || Masla
  end

  # Get all distinct premaslas to build columns
  def pivoted_column_names
    @to_pivot_table.distinct.pluck(@pivot_column)
  end

  # Get all the columns after pivoting and joining
  def all_columns
    @to_join_table.column_names + pivoted_column_names.sort
  end

  # Generate crosstab queries
  def pivot_table_crosstab_queries
    # extra_info Arel::Table
    pivot_table_arel = @to_pivot_table.arel_table

    # SQL data type for the MoreInfo.info column
    pivot_table_sql_type = @to_pivot_table.columns.find { |c| c.name == @pivot_column }&.sql_type

    # Part 1 of crosstab
    qry_txt = pivot_table_arel.project(
      pivot_table_arel[@pivot_index],
      pivot_table_arel[@pivot_column],
      pivot_table_arel[@pivot_value]
    )
    # Part 2 of the crosstab
    cats = pivot_table_arel.project(pivot_table_arel[@pivot_column]).distinct
    # construct the ct portion of the crosstab query
    ct = Arel::Nodes::NamedFunction.new('ct', [
                                          Arel::Nodes::TableAlias.new(Arel.sql("\"#{@pivot_index}\""),
                                                                      Arel.sql('bigint')),
                                          *pivoted_column_names.map do |name|
                                            Arel::Nodes::TableAlias.new(Arel::Table.new(name),
                                                                        Arel.sql(pivot_table_sql_type))
                                          end
                                        ])
    [qry_txt, cats, ct]
  end

  # Query to pivot the table
  def pivot_table
    # crosstab queries
    qry_txt, cats, ct = *pivot_table_crosstab_queries

    # build the crosstab(...) AS ct(...) statement
    crosstab = Arel::Nodes::As.new(
      Arel::Nodes::NamedFunction.new('crosstab', [Arel.sql("'#{qry_txt.to_sql}'"),
                                                  Arel.sql("'#{cats.to_sql}'")]),
      ct
    )

    # Arel::Table to use for querying
    tbl = Arel::Table.new('ct')
    # final query construction
    tbl.project(tbl[Arel.star]).from(crosstab)
  end

  # Join the pivot table to the table to join
  def join_table
    sub = Arel::Table.new('subq')
    sub_query = Arel::Nodes::As.new(pivot_table, Arel.sql(sub.name))

    join_condition = Arel::Nodes::On.new(@to_join_table.arel_table[:id].eq(sub[@pivot_index]))

    @to_join_table
      .joins(Arel::Nodes::OuterJoin.new(sub_query, join_condition))
      .select(@to_join_table.arel_table[Arel.star], *pivoted_column_names.map { |column| sub[column.intern] })
  end
end
