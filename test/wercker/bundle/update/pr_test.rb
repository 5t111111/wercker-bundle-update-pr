require 'test_helper'

class Wercker::Bundle::Update::PrTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Wercker::Bundle::Update::Pr::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
