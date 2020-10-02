class Enroll < ApplicationRecord
  belongs_to :client

  def plan
    Plan.all[1]
  end
end
