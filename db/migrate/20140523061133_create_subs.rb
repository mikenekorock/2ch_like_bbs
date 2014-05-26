class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title
      t.string :name
      t.text :text
      t.boolean :done, default: false
      t.references :main, index: true

      t.timestamps
    end
  end
end
