class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.belongs_to :article

      t.timestamps
    end
  end
end
