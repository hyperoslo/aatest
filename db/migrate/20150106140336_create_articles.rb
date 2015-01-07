class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :sectionable_id
      t.string :sectionable_type

      t.timestamps
    end
  end
end
