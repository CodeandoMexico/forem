class AddColumnAproveToChambas < ActiveRecord::Migration[6.1]
  def change
    add_column :chambas, :approve, :boolean
  end
end
