# This migration comes from glysellin_engine (originally 20140218165003)
class AddAttrsToCustomers < ActiveRecord::Migration
  def change
    create_table :glysellin_customers do |t|
      t.string :first_name
      t.string :last_name
    end
  end
end
