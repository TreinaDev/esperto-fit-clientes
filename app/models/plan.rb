class Plan
  attr_reader :id, :name, :monthly_payment, :permanency, :subsidiary

  def initialize(id:, name:, monthly_payment:, permanency:, subsidiary:)
    @id = id
    @name = name
    @monthly_payment = monthly_payment
    @permanency = permanency
    @subsidiary = subsidiary
  end

  def self.find(id, subsidiary_id)
    id = id.to_i
    sub = Subsidiary.find(subsidiary_id)
    sub.plans.find { |hash| hash.id == id }
  end

  def description
    "#{name} - #{ActionController::Base.helpers.number_to_currency(monthly_payment)}"
  end
end
