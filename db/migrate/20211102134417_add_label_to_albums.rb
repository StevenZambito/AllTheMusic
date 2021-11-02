class AddLabelToAlbums < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :label, :string
  end
end
