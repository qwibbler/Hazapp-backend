class ApplicationController < ActionController::Base
  def premasla_pivot_table
    @table = PivotTable::Grid.new do |g|
      g.source_data  = PreMasla.all
      g.column_name  = :premasla
      g.row_name     = :masla
      g.field_name   = :value
    end
    @table.build
  end
end
