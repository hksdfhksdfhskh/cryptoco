require 'rails_helper'

describe Currency, type: :model do
  subject { create(:currency) }

  it 'should not allow creating record for the same date and currency' do
    record = build(:currency, date: subject.date, code: subject.code)
    expect(record).not_to be_valid

    record.date += 1.day
    expect(record).to be_valid
  end
end
