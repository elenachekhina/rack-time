require_relative 'current_time_format'

class App
  def call(env)
    @request = Rack::Request.new(env)
    if @request.get? && !@request.params['format'].nil?
      Rack::Response.new(body, status).finish
    else
      Rack::Response.new("Not Found: #{@request.request_method} #{@request.fullpath}", 404).finish
    end
  end

  private

  def curr_time_service
    curr_time_service ||= CurrentTimeFormat.new.call(@request.params['format'])
  end

  def errors?
    !curr_time_service.unavailable_formats.length.zero?
  end

  def status
    errors? ? 400 : 200
  end

  def body_error
    "Unknown time format [#{curr_time_service.unavailable_formats.join(', ')}]"
  end

  def body
    errors? ? body_error : curr_time_service.response
  end
end
