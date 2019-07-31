require 'rails_helper'

describe Worth, type: :model do
  subject { create(:worth) }

  it 'should not allow creating record for the same date and currency' do
    record = build(:worth, date: subject.date, coin: subject.coin)
    expect(record).not_to be_valid

    record.date += 1.day
    expect(record).to be_valid
  end
end
