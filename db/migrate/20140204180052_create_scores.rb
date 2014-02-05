class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :player
      t.references :game
      t.string :result

      t.timestamps
    end
    add_index :scores, :player_id
    add_index :scores, :game_id
  end
end
