class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.text :secret
      t.text :moves

      t.timestamps
    end
  end
end
