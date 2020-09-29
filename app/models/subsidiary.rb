class Subsidiary
  attr_reader :id, :name, :address, :cep

  def initialize(id:, name:, address:, cep:)
    @id = id
    @name = name
    @address = address
    @cep = cep
  end

  def self.all
    []
  end
end
