require 'rails_helper'

RSpec.describe Visit, type: :model do
  describe 'associations' do
    it { should belong_to(:short_link) }
  end
end
