class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "invalid email format" }, uniqueness: true
  has_one :wallet, as: :walletable, dependent: :destroy
  after_create :create_wallet

  private

  def create_wallet
    Wallet.create(walletable: self, balance: 0.0)
  end
end
