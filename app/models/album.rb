class Album < ApplicationRecord
  belongs_to :user
  belongs_to :genre

  has_one_attached :album_cover
end
