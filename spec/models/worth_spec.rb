require 'rails_helper'

describe Worth, type: :model do
  subject { create(:worth) }

  it 'should not allow creating record for the same date and currency' do
    record = build(:worth, quote_time: subject.quote_time, coin: subject.coin)
    expect(record).not_to be_valid

    record.quote_time += 1.second
    expect(record).to be_valid
  end
end
