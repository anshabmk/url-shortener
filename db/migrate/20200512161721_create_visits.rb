class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.references :short_link, null: false, foreign_key: true
      t.string :ip_address
      t.string :country

      t.timestamps
    end
  end
end
