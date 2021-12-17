class CreateAdminCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_courses do |t|
      t.string :name
      t.boolean :published
      t.string :slug
      t.text :description
      t.text :meta_description
      t.text :meta_title

      t.timestamps
    end
  end
end
