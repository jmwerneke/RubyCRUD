class CreateDepts < ActiveRecord::Migration
  def change
    create_table :depts do |t|
      t.string :department
      t.string :dept_num
      t.string :dept_name

      t.timestamps null: false
    end
  end
end
