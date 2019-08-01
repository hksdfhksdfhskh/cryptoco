class Coin < ApplicationRecord
  validates_presence_of :slug, :symbol, :name

  belongs_to :platform, class_name: 'Coin', optional: true
  has_many :worths
end
