require 'test/unit'

require_relative '../lib/halidator'
require_relative './json_strings'

class JsonSchemaTest < Test::Unit::TestCase
  def test_haltalk_users
    hal = Halidator.new(JsonStrings.haltalk_users, :json_schema)
    assert true == hal.valid?
  end

  def test_invalid_haltalk_users
    hal = Halidator.new(JsonStrings.invalid_haltalk_users, :json_schema)
    assert true == hal.valid?
  end

  def test_haltalk_users_posts
    hal = Halidator.new(JsonStrings.haltalk_users_mike_posts, :json_schema)
    assert true == hal.valid?
  end

  def test_haltalk_posts_latest
    hal = Halidator.new(JsonStrings.haltalk_posts_latest, :json_schema)
    assert true == hal.valid?
  end

  def test_dtime_root
    hal = Halidator.new(JsonStrings.dtime_root, :json_schema)
    assert true == hal.valid?
  end

end
