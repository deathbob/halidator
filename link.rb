class Link

  def initialize(hash)
    @hash = hash
  end

  def valid?
    foo = @hash['self'] || @hash['curie']
    bar = foo && foo['href']
    if bar
      validate_link_format(bar)
    end
  end

  def validate_link_format(str)
    # check if it's a template
  end
end
