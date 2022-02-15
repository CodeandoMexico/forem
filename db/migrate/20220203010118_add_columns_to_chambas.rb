class AddColumnsToChambas < ActiveRecord::Migration[6.1]
  def change
    add_column :chambas, :organization, :string
    add_column :chambas, :location, :string
    add_column :chambas, :sueldo, :integer
  end
end
