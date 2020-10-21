class AddTelephoneToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :telephone, :string
  end
end
