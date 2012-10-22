require 'test/unit'
require 'open-uri'

require 'debugger'

require './halidator'
class HalidatorTest < Test::Unit::TestCase
  def test_haltalk_users
    url = "http://haltalk.herokuapp.com/users.json"
    json_string = open(url){|f| f.read}
    hal = Halidator.new(json_string)
    assert false == hal.valid?
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

  def dtime_root
    #curl  -H "Accept: application/json"  https://api.dtime.com
    <<-json
{"_links":{"self":{"href":"https://api.dtime.com/","rel":"self"},"dtime:developers:documentation":{"href":"https://api.dtime.com/docs","rel":"dtime:developers:documentation"},"dtime:sitemap":{"href":"https://api.dtime.com/sitemap","rel":"dtime:sitemap"},"dtime:dashboard":{"href":"https://api.dtime.com/dashboard","rel":"dtime:dashboard"},"dtime:dashboard:developers":{"href":"https://api.dtime.com/developer_dashboard","rel":"dtime:dashboard:developers"},"dtime:dashboard:admin":{"href":"https://api.dtime.com/admin_dashboard","rel":"dtime:dashboard:admin"},"dtime:website":{"href":"https://www.dtime.com/{+url}","templated":true,"href-vars":{"url":"string"},"rel":"dtime:website"},"curie":{"name":"dtime","href":"https://api.dtime.com/docs/rels/{+relation}","rel":"curie","templated":true},"dtime:root":{"href":"https://api.dtime.com/","rel":"dtime:root"}}}
json
  end

  def test_dtime_root
    hal = Halidator.new(dtime_root)
    assert true == hal.valid?
  end
end
