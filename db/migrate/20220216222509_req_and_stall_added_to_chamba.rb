class ReqAndStallAddedToChamba < ActiveRecord::Migration[6.1]
  def change
    add_column :chambas, :requirements, :string
    add_column :chambas, :stall, :string
  end
end
