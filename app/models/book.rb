class Book < ApplicationRecord
  belongs_to :user
  validates_presence_of :title
  before_update :default_author

  def in_library?(user)
    user.books.include? self
  end

  private

    def default_author
      self.author = 'Unknown' if author.blank?
    end
end
