class Album < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :reviews

  has_one_attached :album_cover

  def self.search(search)
    if search
      where('title LIKE :search OR artist LIKE :search', search: "%#{search}%").order("created_at DESC")
    else
      all.order("created_at DESC")
    end
  end
end
