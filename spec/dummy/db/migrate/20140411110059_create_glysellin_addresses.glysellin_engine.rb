# This migration comes from glysellin_engine (originally 20120206115657)
class CreateGlysellinAddresses < ActiveRecord::Migration
  def change
    create_table :glysellin_addresses do |t|
      t.boolean :activated, :default => true
      t.boolean :company
      t.string :company_name
      t.string :vat_number
      t.string :first_name
      t.string :last_name
      t.text :address
      t.text :address_details
      t.string :zip
      t.string :city
      t.string :country
      t.string :tel
      t.string :fax
      t.text :additional_fields

      t.timestamps
    end
  end
end
