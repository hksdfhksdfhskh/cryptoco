require 'rails_helper'

describe CoinMarketCap do
  subject { described_class }

  it 'raises an error when timed out' do
    response = instance_double(Typhoeus::Response)
    allow(response).to receive(:timed_out?).and_return(true)
    allow_any_instance_of(Typhoeus::Request).to receive(:run).and_return(response)

    expect { subject.list_currencies }.to raise_error(CoinMarketCap::TimeoutError)
  end

  it 'raises an error when error_code is not 0' do
    stub_const("#{described_class}::API_KEY", "INCORRECT_KEY")

    VCR.use_cassette(:coin_market_cap_list_currencies_with_invalid_key) do
      expect { subject.list_currencies }.to raise_error(CoinMarketCap::Error)
    end
  end

  describe '#list_currencies' do
    it 'returns list of currencies' do
      VCR.use_cassette(:coin_market_cap_list_currencies) do
        response = subject.list_currencies
        expect(response['data']).not_to be_blank
        expect(response['data']).to include(include("symbol" => "BTC"))
        expect(response['data']).to include(include("name" => "Bitcoin"))
      end
    end
  end
end
