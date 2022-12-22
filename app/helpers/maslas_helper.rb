module MaslasHelper
  def style_date_time(date)
    date.strftime('%d-%m-%Y %I:%M %p')
  end

  def style_date(date)
    date.strftime('%d-%m-%Y')
  end

  def date_or_time(date)
    date.include?('T') ? style_date_time(Date.parse(date)) : style_date(Date.parse(date))
  end

  def style_entry(entry)
    entry
      .gsub(/["{}\\]/, '')
      .gsub(/startTime=>([^,]*), endTime=>([^,]*)$/) do |_match|
      "S: #{date_or_time(::Regexp.last_match(1))} E: #{date_or_time(::Regexp.last_match(2))}"
    end
  end

  def style_entries(entries, limit = 2)
    entries = entries[0..limit] if entries.size > limit
    entries.map { |entry| style_entry(entry) }.join("\n\n")
  end

  def style_entries_for_show(entries)
    entries.map do |entry|
      entry
        .gsub(/["{}\\]/, '')
        .gsub(/startTime=>([^,]*), endTime=>([^,]*)$/) do |_match|
          "#{date_or_time(::Regexp.last_match(1))},#{date_or_time(::Regexp.last_match(2))};"
        end
        .split(",")
    end
  end

  def style_data(data, key)
    return style_entries(data, 2) if key == 'entries'
    return raw(data[0..120]) if key.include? 'answer'
    return 'True' if data == 't'
    return style_date_time(data) if key[-3..] == '_at'

    data
  end
end
