class PopulateShortLinkVisitsCount < ActiveRecord::Migration[6.0]
  def change
    ShortLink.find_each do |short_link|
      ShortLink.reset_counters(short_link.id, :visits)
    end
  end
end
