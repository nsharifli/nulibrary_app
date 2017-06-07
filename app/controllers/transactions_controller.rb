class TransactionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @my_transactions = Transaction.where(user: current_user)
  end
end
