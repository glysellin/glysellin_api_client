# This migration comes from glysellin_engine (originally 20120206124630)
class CreateGlysellinProductImages < ActiveRecord::Migration
  def change
    create_table :glysellin_product_images do |t|
      t.string :name
      t.integer :imageable_id
      t.string :imageable_type
      t.timestamps
    end
  end
end
