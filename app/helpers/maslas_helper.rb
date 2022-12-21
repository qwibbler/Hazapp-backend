module MaslasHelper
  def style_dateTime(date)
    date.strftime("%d/%m/%Y %I:%M %p")
  end

  def style_date(date)
    date.strftime("%d/%m/%Y")
  end

  # S=>2022-12-01, E=>2022-12-08
  def style_entries(entries)
    entries.map { |entry|
      entry
      .gsub(/["{}\\]/, '')
      .gsub('startTime', 'S')
      .gsub('endTime', 'E')
      .gsub(/>([^,]*)T([^,]*).*?(,|$)/) do |match|
        '>' + style_dateTime(Date.parse(match[1..-1]))
      end
      .gsub('=>', ': ')
      # .gsub('T', ' ')
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
