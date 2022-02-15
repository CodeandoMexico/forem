class CreateChambas < ActiveRecord::Migration[6.1]
  def change
    create_table :chambas do |t|
      t.string :title
      t.string :post_date
      t.string :date
      t.date :exp_date
      t.string :description
      t.string :organization
      t.string :location
      t.integer :salary

      t.timestamps
    end
  end
end
