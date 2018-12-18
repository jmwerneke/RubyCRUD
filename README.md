# RubyCRUD
CRUD Test for KLOVE

Joanne Werneke December 17, 2018

CRUD for Depts
CRUD for Employees (name, contact info.)
Associate Employeee w/Dept. 
View all Employees in a Dept.
Instructions on install run & test

First Create new App with command:  

rails new emp-dept-app/

Then Change your dirctory to access the application:  

cd emp-dept-app/

The Generate the Model for the application (singular)

rails g model employee name address phone email department

This creates 2 files

app/models/employee.rb

db/migrate/[date_time]_create_employees.rb

The employee table in the database will have 5 fields name, address, phone, email, department

Generate a Controller for the application (plural)

rails g controller employees index show new edit

employees_controller.rb gets created along with a employees folder with four files added within the views folder

index.html.erb
show.html.erb
new.html.erb
edit.html.erb

config/routes.rb file gets updated:

Rails.application.routes.draw do
  get employees/index
  get employees/show
  get employees/new
  get employees/edit
end

Update config/routes.db as follows for CRUD operations:

Rails.application.routes.draw do
  resources :employees
end

Migrate Data

class CreateEmployees < ActiveRecord::Migration[5,2]
  def change
    create_table  :employees do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.string :department
      
      t.timestamps
    end
  end
end

Run rake db:migrate 
creates a SQLLite database based on db/migrate/[date_time]_create_employees.rb file.

Add some test records to db/migrate/seeds.rb
Employee.create(name: 'Simon Peter', address: '123 Galliee Rd., Roseville, CA', email:  'sp@gmail.com', phone: '916-777-7777', department:  '  ')
Employee.create(name: '  ', address:  '  ', email:  '  ', phone:  '  ', department:  '  ')
      
      
      
      
