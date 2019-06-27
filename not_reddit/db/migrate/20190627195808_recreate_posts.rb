class RecreatePosts < ActiveRecord::Migration[5.2]
  def change 
    drop_table :posts

    create_table :posts do |t|
      t.string :title, null: false, index: true
      t.string :url
      t.text :content
      t.references :ownerable, polymorphic: true, index: true
    
      t.timestamps
    end
    
  end
end
