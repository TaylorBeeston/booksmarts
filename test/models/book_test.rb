require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def setup
    @valid  = books(:valid)
    @noauth = books(:noauthor)
  end

  test 'should not save without title' do
    book = Book.new
    assert_not book.valid?
  end

  test 'should not save without a user' do
    book = Book.new(title: 'Test')
    assert_not book.valid?
  end

  test 'author should default to unknown' do
    book = Book.new
    assert_equal 'Unknown', book[:author]
  end

  test 'valid book should save even with no author' do
    assert_equal 'This is a Valid Book', @valid[:title]
    assert @valid.valid?, 'Valid Book is not valid'
    assert @noauth.valid?, 'Book with no author is not valid'
  end
end
