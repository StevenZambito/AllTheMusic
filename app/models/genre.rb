class Genre < ApplicationRecord
  has_many :albums
  # validates :genre_id, presence: true
end
