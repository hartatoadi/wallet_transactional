class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :validate_transaction

  def validate_transaction
    if transaction_type == 'credit' && source_wallet.present?
      errors.add(:source_wallet, 'Source wallet should be nil for credit transactions')
    elsif transaction_type == 'debit' && target_wallet.present?
      errors.add(:target_wallet, 'Target wallet should be nil for debit transactions')
    elsif transaction_type == 'transfer' && (source_wallet.nil? || target_wallet.nil?)
      errors.add(:base, 'Transfer transactions require both source and target wallets')
    end
  end
end
