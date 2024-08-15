class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :designation, null: false
      t.references :department, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :reference_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end