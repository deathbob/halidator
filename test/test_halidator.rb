require 'test/unit'
require 'open-uri'
require_relative './json_strings'
require_relative '../lib/halidator'

class HalidatorTest < Test::Unit::TestCase
  def test_haltalk_users
    hal = Halidator.new(JsonStrings.haltalk_users)
    assert true == hal.valid?
  end

  def test_invalid_haltalk_users
    hal = Halidator.new(JsonStrings.invalid_haltalk_users)
    assert false == hal.valid?
    assert hal.errors.join.match /no self in/im
  end

  def test_haltalk_users_posts
    hal = Halidator.new(JsonStrings.haltalk_users_mike_posts)
    assert true == hal.valid?
  end

  def test_haltalk_posts_latest
    hal = Halidator.new(JsonStrings.haltalk_posts_latest)
    assert true == hal.valid?
  end

  def test_dtime_root
    hal = Halidator.new(JsonStrings.dtime_root)
    assert true == hal.valid?
  end

  def test_bad_embedded_string
    hal = Halidator.new(JsonStrings.bad_embedded_string)
    assert false == hal.valid?
    puts hal.errors
  end
end
