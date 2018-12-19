class ApplicationController < ActionController::Base
  
# Prevent CSRF attacks by raising an exception.
  
# For APIs, you may want to use :null_session instead.
  
protect_from_forgery with: :exception
end

class Departments < ApplicationRecord
    has_many :employees
  end
 
  class Employees < ApplicationRecord
    belongs_to :department
  end

def show
    @department.employees = Employee.find(params[:id])
  end