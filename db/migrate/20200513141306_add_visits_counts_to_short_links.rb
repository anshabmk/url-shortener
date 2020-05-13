class AddVisitsCountsToShortLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :short_links, :visits_count, :integer, default: 0
  end
end
