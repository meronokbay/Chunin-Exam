class CreateTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :trackers do |t|
      t.string :platform
      t.references :url, null: false, foreign_key: true

      t.timestamps
    end
  end
end
