class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :emp_num
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :dept_num
      t.string :dept_name

      t.timestamps null: false
    end
  end
end
