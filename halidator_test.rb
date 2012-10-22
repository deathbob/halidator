require 'test/unit'
require 'open-uri'

require 'debugger'

require './halidator'
class HalidatorTest < Test::Unit::TestCase
  def test_haltalk_users
    url = "http://haltalk.herokuapp.com/users.json"
    json_string = open(url){|f| f.read}
    hal = Halidator.new(json_string)
    assert true == hal.valid?
  end

  def test_haltalk_users_posts
    url = "http://haltalk.herokuapp.com/users/mike/posts.json"

    json_string = open(url){|f| f.read}
    hal = Halidator.new(json_string)
    assert true == hal.valid?
  end

  def test_haltalk_posts_latest
    url = 'http://haltalk.herokuapp.com/posts/latest.json'

    json_string = open(url){|f| f.read}
    hal = Halidator.new(json_string)
    assert true == hal.valid?
  end
end
