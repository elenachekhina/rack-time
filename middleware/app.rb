require_relative 'time_format'

class App
  def call(env)
    @method = env['REQUEST_METHOD']
    @path = env['PATH_INFO']
    @query = URI.decode_www_form_component(env['QUERY_STRING'])
    [status, headers, body]
  end

  private

  def status
    if @method != 'GET' || @path != '/time' || @query.match(/\bformat\b/).length != 1
      404
    elsif !TimeFormat.new.check_format(/format=(.+)/.match(@query)[1]).empty?
      400
    else
      200
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    [TimeFormat.new.format(Time.now, /format=(.+)/.match(@query)[1])]
  end

end