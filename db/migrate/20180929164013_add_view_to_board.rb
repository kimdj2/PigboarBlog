class AddViewToBoard < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :view, :int
  end
end
