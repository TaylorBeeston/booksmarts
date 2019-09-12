require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @book = books(:valid)
    @user = users(:taylor)
    sign_in @user
  end

  test "shouldn't get index if not signed in" do
    sign_out @user
    get books_url
    assert_redirected_to new_user_session_path
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post books_url, params: { book: { title: 'Test', author: 'Test', 
                                        user_id: @user.id } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test "should show book" do
    get book_url(@book)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_url(@book)
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { book: { title: 'updated title' } }
    assert_redirected_to book_url(@book)
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end
end
