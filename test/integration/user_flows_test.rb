require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @taylor = users(:taylor)
    @other  = users(:not_taylor)
  end

  test "sign in sign out links on home page" do
    get root_path
    assert_response :success
    assert_select "a[href=?]", new_user_session_path
    sign_in @taylor
    get root_path
    assert_response :success
    assert_select "a[href=?]", destroy_user_session_path
  end

  test 'new user should have three default libraries' do
    user = { username: 'coolguy123', email: 'abc123@123.com',
             password: Devise::Encryptor.digest(User, 'password') }

    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: user }
    end

    libraries = User.last.libraries

    assert_equal 3, libraries.count
    assert libraries.any? { |lib| lib.name == 'Books I Have Read' }
    assert libraries.any? { |lib| lib.name == 'Books I Want to Read' }
    assert libraries.any? { |lib| lib.name == 'Books I am Reading' }
  end

  # Do this after getting things up and running
  # test "omniauth links on signup page" do
  #   get new_user_registration_path
  #   assert_response :success
  #   assert_select "a[href=?]", user_facebook_omniauth_authorize_path
  #   assert_select "a[href=?]", user_twitter_omniauth_authorize_path
  #   assert_select "a[href=?]", user_google_omniauth_authorize_path
  #   assert_select "a[href=?]", user_amazon_omniauth_authorize_path
  # end
end
