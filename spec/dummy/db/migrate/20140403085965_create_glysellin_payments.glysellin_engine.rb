# This migration comes from glysellin_engine (originally 20120206130920)
class CreateGlysellinPayments < ActiveRecord::Migration
  def change
    create_table :glysellin_payments do |t|
      t.string :status
      t.integer :type_id
      t.integer :order_id
      t.datetime :last_payment_action_on
      t.integer :transaction_id

      t.timestamps
    end
  end
end
