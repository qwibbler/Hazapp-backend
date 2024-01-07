masla[:entries].map! do |entry|
  eval(entry)
end

json.extract! masla, :id, :typeOfInput, :typeOfMasla, :entries, :answerEnglish, :answerUrdu, :user_id, :created_at

json.more_infos do
  @masla.more_infos.each do |info|
    Rails.logger.debug info
    val = if info.value == 't'
            true
          elsif info.value == 'f'
            false
          else
            info.value
          end
    json.set!(info.info, val)
  end
end

json.url masla_url(masla, format: :json)
