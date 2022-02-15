class AddImgRouteColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :chambas, :cover_image, :string
  end
end
