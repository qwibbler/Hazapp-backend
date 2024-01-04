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
      "S:_#{date_or_time(::Regexp.last_match(1))} E:_#{date_or_time(::Regexp.last_match(2))}"
    end
  end

  def style_entries(entries, limit = 1)
    simple_format(entries[0...limit].map do |entry|
                    style_entry(entry)
                  end.join("\n\n") + (entries.length > limit ? "\n..." : ''))
  end

  def style_entries_for_show(entries)
    entries.map do |entry|
      entry
        .gsub(/["{}\\]/, '')
        .gsub(/startTime=>([^,]*), endTime=>([^,]*)$/) do |_match|
          "#{date_or_time(::Regexp.last_match(1))},#{date_or_time(::Regexp.last_match(2))};"
        end
        .split(',')
    end
  end

  def words_from_camelcase(col)
    return col if col.include? 'answer'

    col.gsub(/[A-Z]/) { |match| " #{match}" }.titleize
  end

  def style_user_data(masla)
    link_to masla.user.username.titleize, user_path(masla.user)
  end

  def long_data_key?(key, data)
    (key.include?('answer') || key.include?('question')) && data.length > 55
  end

  def style_long_data(data, limit_answer)
    sanitize(data[10..limit_answer])
  end

  def style_data(masla, key, limit_entries = 1, limit_answer = 55)
    return style_user_data(masla) if key.include?('user')

    data = masla[key]
    return style_entries(data, limit_entries) if key == 'entries'
    return style_long_data(data, limit_answer) if long_data_key?(key, data)
    return 'True' if data == 't'
    return style_date_time(data) if key.end_with?('_at')

    data
  end
end
