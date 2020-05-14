require "rails_helper"

describe StatsHelper, type: :helper do
  describe '#previous_page' do
    it 'should return the previous page number' do
      assign(:page, 2)
      expect(helper.previous_page).to be 1
    end

    it 'should return nil' do
      assign(:page, 1)
      expect(helper.previous_page).to be nil
    end
  end

  describe '#next_page' do
    it 'should return the next page number' do
      assign(:total_count, 11)
      assign(:per_page, 5)
      assign(:page, 2)

      expect(helper.next_page).to be 3
    end

    it 'should return nil' do
      assign(:total_count, 11)
      assign(:per_page, 5)
      assign(:page, 3)

      expect(helper.next_page).to be nil
    end
  end
end
