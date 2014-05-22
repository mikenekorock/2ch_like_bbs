class CreateMains < ActiveRecord::Migration
  def change
    create_table :mains do |t|
      t.string :title
      t.string :name
      t.text :text

      t.timestamps
    end
  end
end
