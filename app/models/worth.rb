class Worth < ApplicationRecord
  validates :quote_time, uniqueness: { scope: [:coin_id] }

  belongs_to :coin

  scope :latest_quote_ordering, -> { order('quote_time DESC') }
end
