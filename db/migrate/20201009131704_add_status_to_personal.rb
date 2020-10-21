class AddStatusToPersonal < ActiveRecord::Migration[6.0]
  def change
    add_column :personals, :status, :integer
  end
end
