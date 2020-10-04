class PaymentOption < ApplicationRecord
  validates :name, uniqueness: true, presence: true
end
