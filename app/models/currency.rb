class Currency < ApplicationRecord
  validates :date, uniqueness: { scope: [:code] }
end
