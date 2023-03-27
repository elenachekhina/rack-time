class TimeFormat
  AVAILABLE_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S',
  }.freeze

  def format(time, format)
    not_available_formats = check_format(format)
    return "Unknown time format [#{not_available_formats.join(', ')}]" unless not_available_formats.empty?

    time.strftime(format.gsub(/(year)|(month)|(day)|(hour)|(minute)|(second)/, AVAILABLE_FORMATS))
  end

  def check_format(format)
    format.scan(/\b(\w+)\b/i).filter { |f| !AVAILABLE_FORMATS.include? f.join() }
  end

end
