class AdminBillsController < ApplicationController
  load_and_authorize_resource :bill, class: 'Bill'
  before_action :check_admin_role

  def index
    @bills = Bill.all
  end

  def update
    @bill = Bill.find(params[:id])
    if @bill.update(bill_params)
      flash[:notice] = 'Bill status was successfully updated.'
      redirect_to admin_bills_path
    else
      flash[:error] = 'Failed to update bill status.'
      redirect_to admin_bills_path
    end
  end

  private

  def check_admin_role
    authorize! :manage, Bill
  rescue CanCan::AccessDenied
    flash[:alert] = "You are not authorized to access this page."
    redirect_to root_path
  end

  def bill_params
    params.require(:bill).permit(:status)
  end
end
