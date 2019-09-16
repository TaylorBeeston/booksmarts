require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @book  = books(:valid)
    @user  = users(:taylor)
    @user2 = users(:not_taylor)
    sign_in @user
  end

  test "shouldn't get index if not signed in" do
    sign_out @user
    get books_url
    assert_redirected_to new_user_session_path
  end

  test 'should get new' do
    get new_book_url
    assert_response :success
  end

  test 'should create book' do
    assert_difference('Book.count') do
      post books_url, params: { book: { title: 'Test', author: 'Test' } }
    end

    assert_redirected_to root_path
  end

  test 'should show book' do
    get book_url(@book)
    assert_response :success
  end

  test 'should get edit' do
    get edit_book_url(@book)
    assert_response :success
  end

  test 'should update book' do
    patch book_url(@book), params: { book: { title: 'updated title' } }
    assert_redirected_to root_path
  end

  test 'should destroy book' do
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to root_path
  end

  test 'add book to library' do
    sign_out @user
    sign_in  @user2

    assert_difference('User.last.books.count', 1) do
      post add_book_url(@book), params: { user_id: @user2.id  }
    end
  end

  test "adding a book to your library shouldn't remove it from someone else's" do
    sign_out @user
    sign_in  @user2

    assert_no_difference('User.first.books.count') do
      post add_book_url(@book), params: { user_id: @user2.id  }
    end
  end

  test 'cannot add the same book twice' do
    assert_no_difference('User.first.books.count') do
      post add_book_url(@book), params: { user_id: @user.id  }
    end
  end
end
