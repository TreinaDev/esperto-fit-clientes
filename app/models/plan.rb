class Plan
  attr_reader :id, :name, :monthly_payment, :permanency, :subsidiary

  def initialize(id:, name:, monthly_payment:, permanency:, subsidiary:)
    @id = id
    @name = name
    @monthly_payment = monthly_payment
    @permanency = permanency
    @subsidiary = subsidiary
  end

  def self.all
    [new(id: 1, name: 'Esperto', monthly_payment: 90.00, permanency: 1, subsidiary: Subsidiary.find),
     new(id: 2, name: 'Black', monthly_payment: 120.00, permanency: 12, subsidiary: Subsidiary.find)]
  end

  def self.find
    all[0]
  end

  def description
    "#{name} - #{ActionController::Base.helpers.number_to_currency(monthly_payment)}"
  end
end
