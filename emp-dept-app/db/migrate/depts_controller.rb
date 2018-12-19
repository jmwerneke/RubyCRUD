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
