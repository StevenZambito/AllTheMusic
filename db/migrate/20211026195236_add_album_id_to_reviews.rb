class AddAlbumIdToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :album_id, :integer
  end
end
