class CurrentTimeFormat
  AVAILABLE_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S',
  }.freeze

  Result = Struct.new(:format) do
    def response
      Time.now.strftime(format.gsub(/(year)|(month)|(day)|(hour)|(minute)|(second)/, AVAILABLE_FORMATS))
    end

    def unavailable_formats
      format.scan(/\b(\w+)\b/i).filter { |f| !AVAILABLE_FORMATS.include? f.join }
    end
  end

  def call(format)
    Result.new(format)
  end
end
