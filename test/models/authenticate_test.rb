require "test_helper"

class AuthenticateTest < ActiveSupport::TestCase

  def authenticate
    @authenticate ||= Authenticate.new
  end

  def test_valid
    assert authenticate.valid?
  end

end
