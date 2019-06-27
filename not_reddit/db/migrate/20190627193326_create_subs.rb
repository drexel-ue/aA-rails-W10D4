class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.string :title, null: false, index: true
      t.text :description, null: false
      t.integer :moderator_id, null: false
    end
  end
end
