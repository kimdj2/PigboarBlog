class AddNumcountToBoard < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :likes_count, :integer
  end
end
