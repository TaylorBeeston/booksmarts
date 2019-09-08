require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test 'should not save without title' do
    book = Book.new
    assert !book.save
  end

  test 'should not save without a user' do
    book = Book.new(title: 'Test')
    assert !book.save
  end

  test 'author should default to unknown' do
    book = Book.new
    assert book[:author] = 'Unknown'
  end
end
