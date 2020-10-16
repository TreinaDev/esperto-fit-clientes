class Subsidiary
  attr_reader :id, :name, :address, :cnpj, :token

  def initialize(id:, name:, address:, cnpj:, token:)
    @id = id
    @name = name
    @address = address
    @cnpj = cnpj
    @token = token
  end

  def self.all
    response = Faraday.get "#{Rails.configuration.apis['subsidiaries']}/subsidiaries"

    if response.status == 200
      list = JSON.parse(response.body, symbolize_names: true)
      list.map do |item|
        new(id: item[:id], name: item[:name],
            address: item[:address], cnpj: item[:cnpj], token: item[:token])
      end
    else
      []
    end
  end

  def self.find(id)
    id = id.to_i
    all.find { |hash| hash.id == id }
  end

  def plans
    response = Faraday.get("#{id}/api/plans")
    if response.status == 200
      JSON.parse(response.body, symbolize_names: true).map do |item|
        Plan.new(**{ **item, subsidiary: id })
      end
    else
      []
    end
  end

  def self.search(query)
    all.filter do |subsidiary|
      subsidiary.name.downcase.include?(query.downcase) or
        subsidiary.address.downcase.include?(query.downcase)
    end
  end
end
