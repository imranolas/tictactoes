class CreateSnakeScores < ActiveRecord::Migration
  def change
    create_table :snake_scores do |t|
      t.references :user
      t.integer :score

      t.timestamps
    end
    add_index :snake_scores, :user_id
  end
end
