class AddIndexToPersonal < ActiveRecord::Migration[6.0]
  def change
    add_index :personals, :cref, unique: true
    add_index :personals, :cpf, unique: true
  end
end
