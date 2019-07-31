require 'rails_helper'

describe CurrenciesListImporterService do
  subject { described_class.new }

  describe '#process' do
    context 'when there is no records' do
      it 'will create the records' do
        VCR.use_cassette(:coin_market_cap_list_currencies) do
          expect {
            subject.process
          }.to change {
            Coin.count
          }.from(0)
        end

        # test for platform creation
        expect(Coin.where(slug: ['ultra', 'ovcode', 'ors-group'])).to be_all { |c| c.platform.present? }
      end
    end

    context 'when a coin record exists' do
      it 'will not create a new record' do
        bitcoin = create :coin

        VCR.use_cassette(:coin_market_cap_list_currencies) do
          expect {
            subject.process
          }.not_to change {
            Coin.where(slug: bitcoin.slug).count
          }
        end
      end

      it 'can updates its data' do
        bitcoin = create :coin, is_active: false

        VCR.use_cassette(:coin_market_cap_list_currencies) do
          expect {
            subject.process
          }.to change {
            bitcoin.reload.is_active
          }.from(false).to(true)
        end
      end

      it 'can remove platform association' do
        somecoin = create :coin, slug: 'somecoin'
        bitcoin = create :coin, slug: 'bitcoin', platform: somecoin

        VCR.use_cassette(:coin_market_cap_list_currencies) do
          expect {
            subject.process
          }.to change {
            bitcoin.reload.platform
          }.to(nil)
        end
      end
    end
  end
end
