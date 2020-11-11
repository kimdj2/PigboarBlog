class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true
      t.references :user, foreign_key: true
      t.text :content, null: false
      t.references :parent
      t.timestamps
    end
    add_foreign_key :comments, :comments, :column => :parent_id
  end
end
