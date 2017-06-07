class TransactionsController < ApplicationController
  def index
    @my_transactions = Transaction.where(user_id: current_user.id)
  end
end
