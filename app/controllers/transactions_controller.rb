class TransactionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @my_transactions = Transaction.where(user: current_user, returned_at: nil).order(borrowed_at: :desc).paginate(page: params[:page], per_page: 5)
  end
end
