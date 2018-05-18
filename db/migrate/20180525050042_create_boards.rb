class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards do |t|
      t.string :title
      t.text :contents
      t.string :author
      t.string :image_path

      t.timestamps
    end
    execute "ALTER TABLE boards ADD FOREIGN KEY (author) references users(username);"
  end
end
