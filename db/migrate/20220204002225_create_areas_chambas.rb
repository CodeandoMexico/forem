class CreateAreasChambas < ActiveRecord::Migration[6.1]
  def change
    create_table :areas_chambas do |t|
      t.references :chamba, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
