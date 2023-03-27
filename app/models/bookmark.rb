class Bookmark < ApplicationRecord
  belongs_to :list
  belongs_to :movie

  validates :comment, length: {minimum: 6 }
  validates :movie, uniqueness: {
    scope: :list,
    message: 'The movie can join the list only one time'
  }

end
