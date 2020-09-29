class Subsidiary
  attr_reader :name, :address, :neighborhood

  def initialize(name:, address:, neighborhood:)
    @name = name
    @address = address
    @neighborhood = neighborhood
  end

  def self.search
  end
end
