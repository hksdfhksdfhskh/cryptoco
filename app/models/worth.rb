class Worth < ApplicationRecord
  validates :quote_time, uniqueness: { scope: [:coin_id] }

  belongs_to :coin

  scope :latest, -> { order('quote_time DESC') }
end
