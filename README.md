# RubyCRUD
CRUD Test for KLOVE

Joanne Werneke December 17, 2018

CRUD for Depts
CRUD for Employees (name, contact info.)
Associate Employeee w/Dept. 
View all Employees in a Dept.
Instructions on install run & test

RUBY on RAILS instructions:

First Create new App with command:  

rails new emp-dept-app/

Then Change your dirctory to access the application:  

cd emp-dept-app/

The Generate the Model for the application (singular)

rails g model employee emp_num name address phone email department

This creates 2 files

app/models/employee.rb

db/migrate/[date_time]_create_employees.rb

The employee table in the database will have 7 fields emp_num, name, address, phone, email, dept_num, dept_name

rails g model dept department dept_num dept_name

This creates 2 files

app/models/dept.rb

db/migrate/[date time]_create_dept.rb

The dept table in the database will have 2 fields department dept_num dept_name

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

rails g controller departments index show new edit

depts_controller.rb gets created along with a dept folder with four files added within the views folder (same as employees_controller.rb folder)

Update config/routes.db as follows for CRUD operations:

Rails.application.routes.draw do
  resources :employees
  resources :departments
end

Migrate Data

class CreateEmployees < ActiveRecord::Migration[5,2]
  def change
    create_table  :employees do |t|
      t.string :emp_num
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.string :dept_name
      t.string :dept_num
      
      t.timestamps
    end
  end
end

Run rake db:migrate 
creates a SQLLite database based on db/migrate/[date_time]_create_employees.rb file.

class CreateDepts < ActiveRecord::Migration[5,2]
  def change
    create_table  :departments do |t|
      t.string :dept_num
      t.string :dept_name
      
      t.timestamps
    end
  end
end

Run rake db:migrate
creates a SQLLite database based on db/migrate/[date time]_create_deptartments.rb file.

Add some test records to db/migrate/seeds.rb
Employee.create(emp_num: '01', name: 'Simon Peter', address: '123 Galliee Rd., Roseville, CA', email:  'sp@gmail.com', phone: '916-777-1777', department:  'listener services')  ')
Employee.create(emp_num: '02', name: 'John', address:  '456 Galliee Rd., Roseville, CA', email:  'j@gmail.com  ', phone:  '916-777-2777', department:  'IT services')
   
rake db:seed

Add some test records db/migrate/seeds.rb
Department.create(dept_num: '01', dept_name: 'listener services')
Department.create(dept_num: '02', dept_name: 'IT services')

check if data has been added run:

rails console or rails c

the run:

rails routes

CRUD for RUBY on RAILS

CreateReadUpdateDelete
Goal: List all Employees

Controller-app/controllers/employees_conroller.rb,index method

def index 
  @employees = employee.all
end

Index-views/employees/index.html.erb
<ul>
  <% @employees.each do |employee| %>
    <li><% link_to employee.name, employee_path(employee) %><li>
    <% end %>
<ul>
  
  Then run:
  
  rails server or rails s
  
  You should see neat but simple html on localhost:3000
  
  CreateReadUpdateDelete
  Goal:  List all Departments
  
  Controller-app/controllers/departments_controller.rb, index method
  
  def index
    @departments = department.all
  end
  
  Index-views/departments/index.html.erb
  <ul>
    <% @departments.each do |department| %>
      <li><% link_to dept_name, department_path(department) %><li>
      <% end %>
  <ul>
  
  CreateReadUpdateDelete
  Goal:  List all employees in specific department
  
  Controller-app/controllers/employees_conroller.rb,show method
  
  class Departments < ApplicationRecord
    has_many :employees
  end
 
  class Employees < ApplicationRecord
    belongs_to :department
  end

def show
    @department.employees = Employee.find(params[:id])
  end

Show — views/employees/show.html.erb
 <ul>
    <% @departments.each do |employee| %>
       <li><% link_to employee.name, employee_path(employee) %><li>
      <% end %>
  <ul>
  
  
  CreateReadUpdateDelete
  Goal: Create a new employee
  
  Controller-app/controllers/employees_controller.rb, new and create methods
  
  def new
  
  @employee = Employee.new
 
  end

  def create
    employee = Employee.create(emp_params)

    redirect_to employees_path
  end

  private

  def emp_params
    params.require(:employee).permit(:emp_num, :name, :address, :email, :phone, :dept_num, :dept_name)
  end
  
  
  New-views/employees/new.html.erb
  
  <h3>Create a Employee</h3>
<%= form_with model: @employee do |form| %>
  <%= form.text_field :emp_num, placeholder: "employee number" %>
  <%= form.text_field :name, placeholder: "employee name" %>
  <%= form.text_field :address, placeholder: "employee address" %>
  <%= form.text_field :email, placeholder: "employee email" %>
  <%= form.text_field :phone, placeholder: "employee phone number" %>
  <%= form.text_field :dept_num, placeholder: "department number" %>
  <%= form.text_field :dept_name, placeholder: "department name" %>

  <%= form.submit %>
<% end %>

<!-- <%= form_for @employee do |form| %>
  <%= form.text_field :emp_num, placeholder: "employee number" %>
  <%= form.text_field :name, placeholder: "employee name" %>
  <%= form.text_field :address, placeholder: "employee address" %>
  <%= form.text_field :email, placeholder: "employee email" %>
  <%= form.text_field :phone, placeholder: "employee phone number" %>
  <%= form.text_field :dept_num, placeholder: "department number" %>
  <%= form.text_field :dept_name, placeholder: "department name" %>
   <%= form.submit %>
<% end %> -->

CreateReadUpdateDelete
Goal: Create a new Department

  Controller-app/controllers/departments_controller.rb, new and create methods
  
  def new
  
  @department = Department.new
 
  end

  def create
    department = Department.create(dept_params)

    redirect_to departments_path
  end

  private

  def dept_params
    params.require(:department).permit(:dept_num, :dept_name)
  end
  
  
  New-views/departments/new.html.erb
  
  <h3>Create a Department</h3>
<%= form_with model: @department do |form| %>
  <%= form.text_field :dept_num, placeholder: "department number" %>
  <%= form.text_field :dept_name, placeholder: "department name" %>

  <%= form.submit %>
<% end %>

<!-- <%= form_for @employee do |form| %>
  <%= form.text_field :dept_num, placeholder: "department number" %>
  <%= form.text_field :dept_name, placeholder: "department name" %>
   <%= form.submit %>
<% end %> -->

CreateReadUpdateDelete
Goal:  Update a specific employee's information

Controller — app/controllers/employees_controller.rb, edit and update methods

 def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update(employee_params)

    redirect_to employee_path(@employee)
  end

  private

  def employee_params
    params.require(:employee).permit(:emp_num, :name, :address, :email, :phone, :dept_num, :dept_name)
  end

Edit-views/employee/edit.html.erb

<h3>Update Employee Details</h3>
<%= form_with model: @employee do |form| %>
  <%= form.text_field :emp_num, placeholder: "employee number" %>
  <%= form.text_field :name, placeholder: "employee name" %>
  <%= form.text_field :address, placeholder: "employee address" %>
  <%= form.text_field :email, placeholder: "employee email" %>
  <%= form.text_field :phone, placeholder: "employee phone number" %>
  <%= form.text_field :dept_num, placeholder: "department number" %>
  <%= form.text_field :dept_name, placeholder: "department name" %>

  <%= form.submit %>
<% end %>

CreateReadUpdateDelete
Goal:  Update a specific Department's information

Controller — app/controllers/departments_controller.rb, edit and update methods

 def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    @department.update(department_params)

    redirect_to department_path(@department)
  end

  private

  def department_params
    params.require(:department).permit(:dept_num, :dept_name)
  end

Edit-views/department/edit.html.erb

<h3>Update Department Details</h3>
<%= form_with model: @department do |form| %>
  <%= form.text_field :dept_num, placeholder: "department number" %>
  <%= form.text_field :dept_name, placeholder: "department name" %>

  <%= form.submit %>
<% end %>

CreateReadUpdateDelete
Goal: Delete Employee from database

Controller — app/controllers/employees_controller.rb, destroy method

def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    redirect_to employees_path
  end
  
  Show — views/employees/show.html.erb
  
  <%= link_to 'Remove', @employee, method: :delete, data: { confirm: 'Are you sure?' } %>
  
CreateReadUpdateDelete
Goal: Delete Department from database

Controller — app/controllers/departments_controller.rb, destroy method

def destroy
    @department = Department.find(params[:id])
    @department.destroy

    redirect_to departments_path
  end
  
  Show — views/departments/show.html.erb
  
  <%= link_to 'Remove', @department, method: :delete, data: { confirm: 'Are you sure?' } %>
  
  
  
  CreateReadUpdateDelete
  Current Employee Controller Code:
  
  class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    employee = Employee.create(employee_params)

    redirect_to employee_path(employee)
  end

  def edit
    @employee = Employee.find(params[:id])
    end

  def update
    @employee = Employee.find(params[:id])

    @employee.update(employee_params)

    redirect_to employee_path(@employee)
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    redirect_to employees_path
  end

  private

  def employee_params
    params.require(:employee).permit(:emp_num, :name, :address, :email, :phone, :dept_num, :dept_name)
  end
  
end
    
 Current Department Controller Code:
  
  class DepartmentController < ApplicationController
  def index
    @departments = Department.all
  end

  def show
    @department = Department.find(params[:id])
  end

  def new
    @department = Department.new
  end

  def create
    department = Department.create(department_params)

    redirect_to department_path(department)
  end

  def edit
    @department = Department.find(params[:id])
    end

  def update
    @department = Department.find(params[:id])

    @department.update(department_params)

    redirect_to department_path(@department)
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    redirect_to departments_path
  end

  private

  def department_params
    params.require(:department).permit(:dept_num, :dept_name)
  end
  
end
    
Refactored Controller Employee Code:
class EmployeesController < ApplicationController
  before_action :current_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employee = Employee.all
  end

  def show

  end

  def new
    @employee = Employee.new
  end

  def create
    employee = Employee.create(employee_params)

    redirect_to employee_path(employee)
  end

  def edit

  end

  def update
    @employee.update(employee_params)

    redirect_to employee_path(@employee)
  end

  def destroy
    @employee.destroy

    redirect_to employee_path
  end

  private

  def employee_params
    params.require(:employee).permit(:emp_num, :name, :address, :email, :phone, :dept_num, :dept_name)
     end

  def current_employee
    @employee = Employee.find(params[:id])
  end

end

Add to Index erb file connect all pages in one area:

<table>
  <% @employees.each do |employee| %>
    <tr>
      <td><%= link_to employee.name, employee_path(employee) %></td>
      <td><%= button_to 'Edit', edit_employee_path(employee), method: 'get'%></td>
      <td><%= button_to 'Remove', employee_path(employee), method: 'delete', data: { confirm: 'Are you sure?' } %></td>
  <% end %>
</table>
<%= link_to "Add a New Employee", new_employee_path %>
  
Refactored Controller Department Code:
class Department Controller < ApplicationController
  before_action :current_department, only: [:show, :edit, :update, :destroy]

  def index
    @department = Department.all
  end

  def show

  end

  def new
    @department = Department.new
  end

  def create
    department = Department.create(department_params)

    redirect_to department_path(department)
  end

  def edit

  end

  def update
    @department.update(department_params)

    redirect_to department_path(@department)
  end

  def destroy
    @department.destroy

    redirect_to department_path
  end

  private

  def department_params
       params.require(:department).permit(:dept_num, :dept_name)
     end

  def current_department
    @department = Department.find(params[:id])
  end

end

Add to Department Index erb file connect all pages in one area:

<table>
  <% @department.each do |department| %>
    <tr>
      <td><%= link_to department.name, department_path(department) %></td>
      <td><%= button_to 'Edit', edit_department_path(department), method: 'get'%></td>
      <td><%= button_to 'Remove', department_path(department), method: 'delete', data: { confirm: 'Are you sure?' } %></td>
  <% end %>
</table>
<%= link_to "Add a New Department", new_department_path %>
