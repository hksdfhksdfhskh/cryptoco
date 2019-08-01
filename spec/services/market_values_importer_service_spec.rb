require 'rails_helper'

describe MarketValuesImporterService do
  subject { described_class.new }

  describe '#process' do
    context 'no coins' do
      it 'does not record any market data' do
        VCR.use_cassette(:coin_market_cap_market_data) do
          expect { subject.process }.not_to change { Worth.count }
          expect(subject.errors).not_to be_blank
        end
      end
    end

    context 'bitcoin defined' do
      let!(:bitcoin) { create :coin }

      it 'records data for bitcoin' do
        VCR.use_cassette(:coin_market_cap_market_data) do
          expect { subject.process }.to change {
            Worth.count
          }.from(0).to(1).and change {
            bitcoin.reload.worths.count
          }.from(0).to(1)

          expect(subject.errors).not_to include('bitcoin')
          expect(subject.errors).not_to be_blank
        end
      end

      it 'does not record data with identical quote_time twice' do

      end
    end
  end

end
