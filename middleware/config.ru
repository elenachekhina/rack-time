require 'rack'
require_relative 'app'

use Rack::ContentType, "text/plain"
run Rack::URLMap.new(
  '/time' => App.new
)
