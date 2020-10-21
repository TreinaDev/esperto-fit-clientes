class AddEnrollToProfile < ActiveRecord::Migration[6.0]
  def change
    add_reference :profiles, :enroll, null: false, foreign_key: true
  end
end
