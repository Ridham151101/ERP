class EmployeesController < ApplicationController
  before_action :check_admin_role, only: [:index, :new, :create, :destroy]
  before_action :set_employee, only: [:edit, :update, :destroy]
  before_action :authorize_employee_update, only: [:edit, :update]
  before_action :authorize_password_change, only: [:change_password, :update_password]

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def create
    ActiveRecord::Base.transaction do
      # Create the associated user
      user = User.new(
        name: "#{employee_params[:first_name]} #{employee_params[:last_name]}",
        email: employee_params[:email],
        password: 'default_password',
        password_confirmation: 'default_password'
      )
      user.add_role(:employee)

      if user.save
        # Create the employee and associate with the user
        @employee = Employee.new(employee_params)
        @employee.user_id = user.id
        @employee.reference_by_id = current_user.id

        if @employee.save
          flash[:notice] = 'Employee was successfully created.'
          redirect_to employees_path
        else
          flash[:error] = @employee.errors.full_messages.join(', ')
          redirect_to new_employee_path
        end
      else
        flash[:error] = user.errors.full_messages.join(', ')
        redirect_to new_employee_path
      end
    end
  end

  def edit
    # @employee is set in set_employee
  end

  def update
    ActiveRecord::Base.transaction do
      # Update the associated user
      if @employee.user.update(
        name: "#{employee_params[:first_name]} #{employee_params[:last_name]}",
        email: employee_params[:email]
      )
        # Update the employee
        if @employee.update(employee_params)
          flash[:notice] = 'Employee was successfully updated.'
          redirect_to employees_path
        else
          flash[:error] = @employee.errors.full_messages.join(', ')
          redirect_to edit_employee_path
        end
      else
        flash[:error] = @employee.user.errors.full_messages.join(', ')
        redirect_to edit_employee_path
      end
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      # Destroy the associated user
      @employee.user.destroy

      # Destroy the employee
      @employee.destroy

      flash[:notice] = 'Employee was successfully destroyed.'
      redirect_to employees_path
    end
  end

  def change_password
    # Render the change_password view
  end

  def update_password
    if current_user.valid_password?(password_params[:current_password])
      if current_user.update(password_params.except(:current_password))
        flash[:notice] = 'Password was successfully changed.'
        redirect_to bills_path
      else
        flash[:error] = current_user.errors.full_messages.join(', ')
        redirect_to change_password_employee_path
      end
    else
      flash[:error] = 'Current password is incorrect.'
      redirect_to change_password_employee_path
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def check_admin_role
    authorize! :manage, Employee
  rescue CanCan::AccessDenied
    flash[:alert] = "You are not authorized to access this page."
    redirect_to bills_path
  end

  def authorize_employee_update
    if current_user.has_role?(:employee) && @employee.user_id != current_user.id
      flash[:alert] = "You are not authorized to update this employee."
      redirect_to bills_path
    end
  end

  def authorize_password_change
    unless current_user.has_role?(:employee)
      flash[:alert] = "You are not authorized to change the password."
      redirect_to root_path
    end
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :designation, :department_id)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
