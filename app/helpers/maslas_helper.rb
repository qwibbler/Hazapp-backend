module MaslasHelper
  def convert_to_html(text)
    html = ''
    paragraphs = text.gsub(/\*(.*?)\*/, '<b>\1</b>').split("\n\n")

    paragraphs.each do |paragraph|
      html << "<p>#{paragraph}</p>\n\n"
    end

    html.html_safe
  end

  def style_date_time(date)
    date.strftime('%d/%m/%Y %I:%M %p')
  end

  def style_date(date)
    date.strftime('%d/%m/%Y')
  end

  def date_or_time(date)
    return date unless date.nil? || date.strip.empty?

    begin
      parsed_date = Date.parse(date)
    rescue ArgumentError
      return date
    end

    date.include?('T') ? style_date_time(parsed_date) : style_date(parsed_date)
  end

  def style_entry(entry)
    parsed_entry = eval(entry)

    start_time = date_or_time(parsed_entry['startTime'])
    end_time = date_or_time(parsed_entry['endTime'])
    value = parsed_entry['value']
    type = parsed_entry['type']

    return "S:_#{start_time} E:_#{end_time}" unless start_time.nil?

    "#{type.capitalize}:_#{value}" unless value.nil?
  end

  def style_entries(entries, limit)
    entries_string = entries.map { |entry| style_entry(entry) }.join(' ')
    entries_string = "#{entries_string[0...limit]}..." if entries_string.length > limit
    entries_string.gsub('_', '&nbsp;').html_safe
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

  def style_user_data(user)
    link_to user.username.titleize, user_path(user)
  end

  def long_data_key?(key, data)
    (key.include?('answer') || key.include?('question')) && data.length > 55
  end

  def style_long_data(data, limit_answer)
    sanitize(data[10..limit_answer])
  end

  def style_data(masla, key, limit_answer = 55)
    return style_user_data(masla.user) if key.include?('user')

    data = masla[key] || masla.info(key)
    return style_entries(data, limit_answer) if key == 'entries'
    return style_long_data(data, limit_answer) if long_data_key?(key, data)
    return 'True' if data == 't'
    return style_date_time(data) if key.end_with?('_at')

    data
  end
end
