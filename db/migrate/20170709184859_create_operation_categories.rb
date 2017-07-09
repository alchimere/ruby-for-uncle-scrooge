class CreateOperationCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :operation_categories do |t|
      t.string :name
      t.integer :operation_category_id

      t.timestamps
    end
  end
end
