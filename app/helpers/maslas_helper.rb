module MaslasHelper
  def style_date(date)
    date.strftime("%d/%m/%Y at %I:%M %p")
  end

  def convert_date(date)
    style_date(Time.at(date.to_f / 1000)) if date.to_i.to_s == date
  end

  def style_entries(entries)
    entries.map { |entry| entry.gsub(/["{}\\]/, '').gsub('Time', '') }
  end
end
