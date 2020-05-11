class AddExpiryAtToShortLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :short_links, :expiry_at, :datetime, null: false
  end
end
