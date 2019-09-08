require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save without email or password' do
    invalid = User.new
    assert_not invalid.valid?
    invalid[:email] = 'abc123@aol.com'
    assert_not invalid.valid?
  end
end
