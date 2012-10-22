require 'json'

class Halidator
  attr_accessor :errors
  def initialize(hal)
    case hal
    when String
      @json_string = hal
    else
      @json = hal
    end

    @errors = []
  end

  def valid?
    parse_json && validate_json_as_hal
  end

  def parse_json
    return true if @json

    @json = JSON.parse(@json_string)
  end

  def validate_json_as_hal
    meets_minimal_JSON_representation? && links_all_valid?(_links) && embedded_valid?
  end

  def embedded_valid?
    return true if _embedded.nil?

    # embedded is always an array of objects, so iterate over each array inside _embedded
    _embedded.all? do |resource_type, array_of_resources|
      array_of_resources.all?{|x| Halidator.new(x).valid?}
    end
  end

  def links_all_valid?(links)
    links.all? do |k, v|
      puts "\n\n", k, v
      case v
      when Array # is an array of links
        v.all?{|x| link_valid?(x)}
      else
        link_valid?(v)
      end
    end
  end

  def link_valid?(link)
    puts "  #{link}"
    link['href'] && template_valid?(link)
  end

  def template_valid?(link)
    return true unless link['templated'] == true

    pairs = 0
    link['href'].each_char.all? do |c|
      if '{' == c
        pairs += 1
        [0, 1].include?(pairs)
      elsif '}' == c
        pairs -= 1
        [0, 1].include?(pairs)
      else
        true
      end
    end
  end


  def meets_minimal_JSON_representation?
    unless _links
      @errors << '_links does not exist'
      return
    end
    unless self_or_curie(_links)
      @errors << 'no self (or curie) in links'
      return
    end
    unless self_href(self_or_curie(_links))
      @errors << 'no href in self_or_curie'
      return
    end

    @errors.empty?
  end


  def _embedded
    @json['_embedded']
  end

  def _links
    @json['_links']
  end

  def self_or_curie(hash)
    hash['self'] || hash['curie']
  end

  def self_href(hash)
    hash['href']
  end

end
