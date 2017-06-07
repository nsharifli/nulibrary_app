class TransactionsController < ApplicationController
  def index
    @my_transactions = Transaction.where(user: current_user)
  end
end
