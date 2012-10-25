require 'json-schema'

module Halidate
  module JsonSchema
    def validate_json_as_hal
      @errors = JSON::Validator.fully_validate(@json, schema)
      @errors.empty?
    end

    def  hal_json_schema_file
      File.dirname(__FILE__) + "/hal.json"
    end

    def schema
      @schema ||= File.open(hal_json_schema_file){|f| JSON.parse(f.read)}
    end
  end
end
