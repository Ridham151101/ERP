class BillsController < ApplicationController
  before_action :set_bill, only: [:edit, :update]

  def index
    @bills = current_user.employee.bills
  end

  def new
    @bill = current_user.employee.bills.build
  end

  def create
    @bill = current_user.employee.bills.build(bill_params)

    if @bill.save
      flash[:notice] = 'Bill was successfully created.'
      redirect_to bills_path
    else
      flash[:error] = @bill.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    # The @bill instance variable is already set by before_action
  end

  def update
    if @bill.update(bill_params)
      flash[:notice] = 'Bill was successfully updated.'
      redirect_to bills_path
    else
      flash[:error] = @bill.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def set_bill
    @bill = current_user.employee.bills.find(params[:id])
  end

  def bill_params
    params.require(:bill).permit(:bill_type, :amount)
  end
end
