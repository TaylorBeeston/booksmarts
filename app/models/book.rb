class Book < ApplicationRecord
  belongs_to :user
  validates_presence_of :title
  before_update :default_author

  has_one_attached :cover

  def in_library?(user)
    user.books.where(id: id).exists? || 
      user.books.where(title: title, author: author).exists?
  end

  private

    def default_author
      self.author = 'Unknown' if author.blank?
    end
end
