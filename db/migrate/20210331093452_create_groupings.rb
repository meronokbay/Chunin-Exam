class CreateGroupings < ActiveRecord::Migration[6.1]
  def change
    create_table :groupings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :url, null: false, foreign_key: true

      t.timestamps
    end
  end
end
