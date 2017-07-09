class CreateOperations < ActiveRecord::Migration[5.1]
  def change
    create_table :operations do |t|
      t.integer :account_id
      t.integer :operation_category_id
      t.string :name
      t.string :original_name
      t.decimal :amount
      t.date :operation_date
      t.date :value_date
      t.text :comment

      t.timestamps
    end
  end
end
