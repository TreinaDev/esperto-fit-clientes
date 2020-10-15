class AddStatusToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :status, :integer
  end
end
