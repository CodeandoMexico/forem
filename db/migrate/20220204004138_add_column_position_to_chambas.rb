class AddColumnPositionToChambas < ActiveRecord::Migration[6.1]
  def change
    add_column :chambas, :position, :string
  end
end
