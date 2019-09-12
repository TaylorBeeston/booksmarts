require 'test_helper'

class BookFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @taylor = users(:taylor)
    @other  = users(:not_taylor)
    @book  = books(:valid)
  end

  test 'invalid book cannot be made' do
    sign_in @taylor
    assert_no_difference 'Book.count' do
      post books_path, params: { book: { author: 'But I supplied an Author!' } }
    end
  end

  test 'valid book can be made' do
    sign_in @taylor
    assert_difference 'Book.count', 1 do
      post books_path, params: { book: { title: 'This is the Title',
                                         author: 'But I supplied an Author!' } }
    end
  end

  test 'new book is assigned to currently signed in user' do
    sign_in @taylor
    post books_path, params: { book: { title: 'Title', author: 'Author' } }
    assert_equal @taylor.id, Book.last.user_id
    sign_out @taylor

    sign_in @other
    post books_path, params: { book: { title: 'Title', author: 'Author' } }
    assert_equal @other.id, Book.last.user_id
  end

  test 'cannot edit user_id' do
    sign_in @taylor
    patch book_path(@book), params: { book: { user_id: 12 } }
    assert_equal @taylor.id, Book.find(@book.id).user_id
  end

  test "cannot edit another user's book" do
    sign_in @other
    patch book_path(@book), params: { book: { title: 'New Title' } }
    assert_not_equal 'New Title', Book.find(@book.id).title

    sign_in @taylor
    patch book_path(@book), params: { book: { title: 'My New Title' } }
    assert_equal 'My New Title', Book.find(@book.id).title
  end

  test 'editing a book to have no auther results in unkown' do
    sign_in @taylor
    patch book_path(@book), params: { book: { author: '' } }
    assert_equal 'Unknown', Book.find(@book.id).author
  end

  test 'cannot edit a book to have a blank title' do
    sign_in @taylor
    patch book_path(@book), params: { book: { title: '' } }
    assert_equal @book.title, Book.find(@book.id).title
  end
end
