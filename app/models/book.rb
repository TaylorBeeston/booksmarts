class Book < ApplicationRecord
  belongs_to :user
  validates_presence_of :title
  before_update :default_author

  private

    def default_author
      self.author = 'Unknown' if author.blank?
    end
end
