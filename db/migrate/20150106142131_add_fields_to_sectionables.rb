class AddFieldsToSectionables < ActiveRecord::Migration
  def change
    add_column :texts, :title, :string
    add_column :images, :image, :string
  end
end
