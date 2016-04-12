class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.text :title
      t.text :description
      t.string :image

      t.timestamps null: false
    end
  end
end
