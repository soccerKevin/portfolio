require "test_helper"

class UserTest < ActiveSupport::TestCase

  def user
    @user ||= NullUser.new
  end

  def test_valid
    #assert user.valid?
  end

=begin
  private 

    class NullUser

    end
=end
end
