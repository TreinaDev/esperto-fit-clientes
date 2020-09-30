class Subsidiary
  attr_reader :name, :address, :neighborhood

  def initialize(name:, address:, neighborhood:)
    @name = name
    @address = address
    @neighborhood = neighborhood
  end

  def self.all
    [
      Subsidiary.new(name: 'Esperto', address: 'Av. Paulista, 20', neighborhood: 'Bela Vista'),
      Subsidiary.new(name: 'Espertão', address: 'Outra Rua, 400', neighborhood: 'Outro Bairro'),
      Subsidiary.new(name: 'Espertinho', address: 'Rua do Outro Lado, 231', neighborhood: 'Bairro Longe')
    ]
  end

  def self.search(query)
    all.filter do |subsidiary|
      subsidiary.name.downcase.include?(query.downcase) or subsidiary.neighborhood.downcase.include?(query.downcase)
    end
  end
end
