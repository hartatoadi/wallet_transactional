class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 15, scale: 2
      t.string :transaction_type
      t.integer :source_wallet_id
      t.integer :target_wallet_id
      t.string :status

      t.timestamps
    end
  end
end
