class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.text :full_url
      t.string :url_digest

      t.timestamps
    end
    add_index :urls, :url_digest, unique: true
  end
end
