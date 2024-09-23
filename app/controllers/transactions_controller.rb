class TransactionsController < ApplicationController
  before_action :set_wallet, only: [:create]

  def create
    ActiveRecord::Base.transaction do
      case params[:transaction_type]
      when 'credit'
        @transaction = Transaction.create!(transaction_type: 'credit', target_wallet: @wallet, amount: params[:amount])
        @wallet.update!(balance: @wallet.balance + @transaction.amount)
      when 'debit'
        raise 'Insufficient funds' if @wallet.balance < params[:amount]
        @transaction = Transaction.create!(transaction_type: 'debit', source_wallet: @wallet, amount: params[:amount])
        @wallet.update!(balance: @wallet.balance - @transaction.amount)
      when 'transfer'
        target_wallet = Wallet.find(params[:target_wallet_id])
        raise 'Insufficient funds' if @wallet.balance < params[:amount]
        @transaction = Transaction.create!(transaction_type: 'transfer', source_wallet: @wallet, target_wallet: target_wallet, amount: params[:amount])
        @wallet.update!(balance: @wallet.balance - @transaction.amount)
        target_wallet.update!(balance: target_wallet.balance + @transaction.amount)
      else
        raise 'Invalid transaction type'
      end
      render json: @transaction, status: :created
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def set_wallet
    @wallet = Wallet.find(params[:wallet_id])
  end
end
