class Worth < ApplicationRecord
  validates :date, uniqueness: { scope: [:coin_id] }

  belongs_to :coin
end
