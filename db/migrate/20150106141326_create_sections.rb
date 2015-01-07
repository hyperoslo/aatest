class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.belongs_to :sectionable, polymorphic: true, index: true
      t.belongs_to :article, index: true

      t.timestamps
    end
  end
end
