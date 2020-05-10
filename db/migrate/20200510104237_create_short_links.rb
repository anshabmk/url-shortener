class CreateShortLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :short_links do |t|
      t.string :token
      t.text :long_url
      t.integer :clicks_count, default: 0

      t.timestamps
    end

    add_index :short_links, :token
  end
end
