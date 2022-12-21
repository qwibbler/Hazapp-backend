module MaslasHelper
  def style_dateTime(date)
    date.strftime("%d-%m-%Y %I:%M %p")
  end

  def style_date(date)
    date.strftime("%d-%m-%Y")
  end

  def date_or_time(date)
    date.include?('T') ? style_dateTime(Date.parse(date)) : style_date(Date.parse(date))
  end

  # S=>2022-12-01, E=>2022-12-08
  def style_entries(entries)
    entries.map { |entry|
      entry
      .gsub(/["{}\\]/, '')
      .gsub(/startTime=>([^,]*), endTime=>([^,]*)$/) do |match|
        "S: #{date_or_time($1)} E: #{date_or_time($2)}"
      end
    }
  end

  def row_number(table, masla)
    table.row_headers.index(masla)
  end

  def find_row(table, masla)
    table.rows[row_number(table, masla)]
  end

  def row_data(table, masla)
    find_row(table, masla).data
  end
end
