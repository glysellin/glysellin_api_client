# This migration comes from glysellin_engine (originally 20120206115004)
class CreateGlysellinOrders < ActiveRecord::Migration
  def change
    create_table :glysellin_orders do |t|
      t.string :ref
      t.string :status
      t.datetime :paid_on
      t.integer :user_id
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.string :state
      t.integer :customer_id

      t.timestamps
    end
  end
end
