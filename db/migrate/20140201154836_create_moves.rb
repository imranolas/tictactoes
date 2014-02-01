class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :player
      t.integer :grid_location

      t.timestamps
    end
    add_index :moves, :player_id
  end
end
