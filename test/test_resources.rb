require 'test/unit'

require_relative '../lib/halidator'
class ResourcesTest < Test::Unit::TestCase
  def valid_json
    { '_links' => {'self' => {'href' => "/asdf/foo"} } }
  end

  def test_embedded_array_of_resources
    json = valid_json.merge({
                               '_embedded' => {
                                 'user' => [
                                             {'_links' => { 'self' => {'href' => '/pickles/pie'} }}
                                            ]
                               }
                             })
    hal = Halidator.new(json)
    assert true == hal.valid?
  end

  def test_embedded_resource
    json = valid_json.merge({
                               '_embedded' => {
                                 'user' => {'_links' => { 'self' => {'href' => '/pickles/pie'} }}
                               }
                             })
    hal = Halidator.new(json)
    assert true == hal.valid?
  end

  def test_deeply_nested_embedded_array_of_resources
    json = valid_json.merge({
                               '_embedded' => {
                                 'user' => [
                                             {'_links' => { 'self' => {'href' => '/pickles/pie'} },
                                              '_embedded' => {
                                                'account' => {'_links' => { 'self' => {"href" => '/users/2/account'}}}}
                                              }
                                            ]
                               }
                             })
    hal = Halidator.new(json)
    assert true == hal.valid?
  end

  def test_deeply_nested_embedded_array_of_resources_no_href
    json = valid_json.merge({
                               '_embedded' => {
                                 'user' => [
                                             {'_links' => { 'self' => {'href' => '/pickles/pie'} },
                                              '_embedded' => {
                                                'account' => {'_links' => { 'self' => {"poop" => '/users/2/account'}}}}
                                              }
                                            ]
                               }
                             })
    hal = Halidator.new(json)
    assert false == hal.valid?
  end


end
