class Team < ApplicationRecord
  has_one :wallet, as: :walletable, dependent: :destroy
  after_create :create_wallet

  private

  def create_wallet
    Wallet.create(walletable: self, balance: 0.0)
  end
end
