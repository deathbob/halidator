module Halidate
  module PureRuby
    def validate_json_as_hal
      meets_minimal_JSON_representation? && links_all_valid? && embedded_valid?
    end

    def links_all_valid?
      _links.all? do |k, v|
        debug "\n\n", k, v

        case v
        when Array # is an array of links
          v.all?{|x| link_valid?(x)}
        else
          link_valid?(v)
        end
      end
    end

    def link_valid?(link)
      debug "    #{link}"

      unless link['href']
        errors << "no href in #{link}"
        return false
      end
      unless template_valid?(link)
        errors << "invalid template for #{link}"
        return false
      end
      true
    end

    def template_valid?(link)
      return true unless link['templated'] == true

      pairs = 0
      res = link['href'].each_char.all? do |c|
        if '{' == c
          pairs += 1
          pairs == 1
        elsif '}' == c
          pairs -= 1
          pairs == 0
        else
          true
        end
      end
      res && (pairs == 0) && link['href'].include?('{')
    end

    def embedded_valid?
      return true if _embedded.nil?

      _embedded.all? do |resource_type, resource|
        case resource
        when Array
          resource.all? do |x|
            hal = Halidator.new(x)
            unless hal.valid?
              errors += hal.errors
            end
          end
        else
          begin
            hal = Halidator.new(resource)
            unless hal.valid?
              errors += hal.errors
            end
          rescue JSON::ParserError
            errors << "'#{resource}' is not a valid embedded object"
            return false
          end
        end
      end
    end

    def meets_minimal_JSON_representation?
      has_links && links_has_self && self_has_href
    end

    def _embedded
      @json['_embedded']
    end

    def _links
      @json['_links']
    end

    def has_links
      if _links
        true
      else
        errors << '_links does not exist'
        false
      end
    end

    def links_has_self
      if _links['self']
        true
      else
        errors << "no self in #{_links.inspect}"
        false
      end
    end

    def self_has_href
      if _links['self']['href']
        true
      else
        errors << "no href in #{_links['self']}"
        false
      end
    end

  end
end
