class AddIndexToClient < ActiveRecord::Migration[6.0]
  def change
    add_index :clients, :cpf, unique: true
  end
end
