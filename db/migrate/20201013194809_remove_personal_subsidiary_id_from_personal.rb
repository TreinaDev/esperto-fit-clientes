class RemovePersonalSubsidiaryIdFromPersonal < ActiveRecord::Migration[6.0]
  def change
    remove_column :personals, :personal_subsidiary_id, :integer
  end
end
