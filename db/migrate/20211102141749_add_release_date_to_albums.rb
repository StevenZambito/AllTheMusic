class AddReleaseDateToAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :release_date, :date
  end
end
