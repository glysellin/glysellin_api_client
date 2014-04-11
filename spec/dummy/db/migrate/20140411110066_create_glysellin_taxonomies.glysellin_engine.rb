# This migration comes from glysellin_engine (originally 20120207175050)
class CreateGlysellinTaxonomies < ActiveRecord::Migration
  def change
    create_table :glysellin_taxonomies do |t|
      t.string :name
      t.string :slug
      t.integer :parent_taxonomy_id

      t.timestamps
    end
  end
end
