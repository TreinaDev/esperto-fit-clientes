class Subsidiary #Plain Old Ruby Object
  attr_reader :id, :name, :address, :cep

  def initialize(id:, name:, address:, cep:)
    @id = id
    @name = name
    @address = address
    @cep = cep
  end

  def self.all
    response = Faraday.get "#{Rails.configuration.apis['subsidiaries']}/subsidiaries"

    if response.status == 200
      list = JSON.parse(response.body, symbolize_names: true)
      list.map do |item|
        new(id: item[:id], name: item[:name],
            address: item[:address], cep: "")
      end
    else
      []
    end
  end

  def self.find(id)
  end

  def self.search(query)
    all.filter do |subsidiary|
      subsidiary.name.downcase.include?(query.downcase) or
        subsidiary.address.downcase.include?(query.downcase) or
        subsidiary.cep.split('-').join == query.split('-').join
    end
  end
end
