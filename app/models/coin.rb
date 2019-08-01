class Coin < ApplicationRecord
  validates_presence_of :slug, :symbol, :name

  belongs_to :platform, class_name: 'Coin', optional: true
  has_many :applications, class_name: 'Coin', foreign_key: 'platform_id'
  has_many :worths

  scope :has_worths, -> {
    joins(:worths).where(worths: {
      id: Worth.select("id").where("worths.coin_id = coins.id").limit(1)
    } )
  }

  scope :ordered_by_market_cap, -> { order("worths.market_capitalization DESC") }
end
