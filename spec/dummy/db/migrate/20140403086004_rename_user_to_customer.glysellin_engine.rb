# This migration comes from glysellin_engine (originally 20140218163514)
class RenameUserToCustomer < ActiveRecord::Migration
  def change
    drop_table :glysellin_customers
    rename_table :users, :glysellin_customers
  end
end
