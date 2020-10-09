class Profile < ApplicationRecord
  belongs_to :enroll

  validates :name, :address, presence: true
end
