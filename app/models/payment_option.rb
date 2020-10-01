class PaymentOption
  attr_reader :id, :name, :subsidiary

  def initialize(id:, name:, subsidiary:)
    @id = id
    @name = name
    @subsidiary = subsidiary
  end

  def self.all
    [new(id: 1, name: 'Boleto', subsidiary: Subsidiary.find),
     new(id: 2, name: 'Cartão de crédito', subsidiary: Subsidiary.find)]
  end
end
