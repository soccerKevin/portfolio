require "test_helper"

class BlogEntryTest < ActiveSupport::TestCase

  def blog_entry
    @blog_entry ||= BlogEntry.new
  end

  def test_valid
    assert blog_entry.valid?
  end

end
