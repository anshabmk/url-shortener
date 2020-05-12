class RemoveClicksCountFromShortLinks < ActiveRecord::Migration[6.0]
  def change
    remove_column :short_links, :clicks_count, :integer
  end
end
