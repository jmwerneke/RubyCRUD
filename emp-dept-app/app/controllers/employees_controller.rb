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

