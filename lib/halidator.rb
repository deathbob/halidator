require 'json'
require_relative './halidate/pure_ruby'
require_relative './halidate/json_schema'

class Halidator
  attr_accessor :errors
  def initialize(hal, engine = :pure_ruby)
    case hal
    when String
      @json_string = hal
      parse_json
    else
      @json = hal
    end
    @errors = []
    if engine == :json_schema
      extend Halidate::JsonSchema
    else
      extend Halidate::PureRuby
    end
  end

  def parse_json
    @json = JSON.parse(@json_string)
  end

  def valid?
    result = validate_json_as_hal
    show_errors
    result
  end

  def debug(*str)
    if $DEBUG
      $stderr.puts str
    end
  end

  def show_errors
    debug ["\nERRORS-VVVVVVVVVVVVVVVVVV",
           *errors,
           "ERRORS-^^^^^^^^^^^^^^^^^^"]
  end

end
