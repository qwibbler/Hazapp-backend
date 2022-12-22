class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  # def premasla_pivot_table(premaslas)
  #   @table = PivotTable::Grid.new do |g|
  #     g.source_data  = premaslas
  #     g.column_name  = :premasla
  #     g.row_name     = :masla
  #     g.field_name   = :value
  #   end
  #   @table.build
  # end
end
