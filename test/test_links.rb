require 'test/unit'

require_relative '../lib/halidator'
class LinksTest < Test::Unit::TestCase

  def valid_json
    { '_links' => {'self' => {'href' => "/asdf/foo"} } }
  end

  def test_must_have_links
    hal = Halidator.new(valid_json)
    assert true == hal.valid?
  end

  def test_no_links
    json = {"asdf" => {'self' => {'href' => '/asdf/foo'} } }
    hal = Halidator.new(json)
    assert false == hal.valid?
    assert hal.errors.include?('_links does not exist')
  end

  def test_links_no_self
    json = {"_links" => {'smurf' => {'href' => '/asdf/foo'} } }
    hal = Halidator.new(json)
    assert false == hal.valid?
    assert hal.errors.include?("no self in #{json['_links'].inspect}")
  end

  def test_links_self_no_href
    json = {"_links" => {'self' => {'hrrf' => '/asdf/foo'} } }
    hal = Halidator.new(json)
    assert false == hal.valid?
    assert hal.errors.include?("no href in #{json['_links']['self']}")
  end

  def test_links_others_valid
    json = valid_json
    json['_links'].merge!({'search' => {'href' => '/search/{str}', 'templated' => true}})
    hal = Halidator.new(json)
    assert true == hal.valid?
  end

  def test_links_others_not_valid
    json = valid_json
    json['_links'].merge!({'search' => '/search/{str}', 'templated' => true})
    hal = Halidator.new(json)
    assert false == hal.valid?
    assert hal.errors.include?("no href in #{json['_links']['search']}")
  end

  def test_array_in_links_too_much_self
    json = valid_json
    json['_links'].merge!({'users' => [
                             {'self' => {"href" => '/users/bar'}},
                             {'self' => {"href" => '/users/bam'}}
                            ]})
    hal = Halidator.new(json)
    assert false == hal.valid?
  end

  def test_array_in_links_just_right
    json = valid_json
    json['_links'].merge!({'users' => [
                             {"href" => '/users/bar'},
                             {"href" => '/users/bam'}
                            ]})
    hal = Halidator.new(json)
    assert true == hal.valid?
  end

  def test_array_of_links_no_href
    json = valid_json
    json['_links'].merge!({'users' => [
                                       {'cow' => 'pig'}
                                      ]})
    hal = Halidator.new(json)
    assert false == hal.valid?
  end

  def test_array_of_links_href_present
    json = valid_json
    json['_links'].merge!({'users' => [
                                       {'href' => '/pig'}
                                      ]})
    hal = Halidator.new(json)
    assert true == hal.valid?
  end

  def test_templated_true_but_no_actual_template
    json = valid_json
    json['_links'].merge!({'users' => [
                                       {'href' => '/pig', 'templated' => true}
                                      ]})
    hal = Halidator.new(json)
    assert false == hal.valid?
  end

  def test_templated_true_and_template_good
    json = valid_json
    json['_links'].merge!({'users' => [
                                       {'href' => '/pig/{id}', 'templated' => true}
                                      ]})
    hal = Halidator.new(json)
    assert true == hal.valid?
  end

  def test_templated_true_and_template_lopsided_left
    json = valid_json
    json['_links'].merge!({'users' => [
                                       {'href' => '/pig/{id', 'templated' => true}
                                      ]})
    hal = Halidator.new(json)
    assert false == hal.valid?
  end

  def test_templated_true_and_template_lopsided_right
    json = valid_json
    json['_links'].merge!({'users' => [
                                       {'href' => '/pig/id}', 'templated' => true}
                                      ]})
    hal = Halidator.new(json)
    assert false == hal.valid?
  end


end
