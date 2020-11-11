class AddColumnBoard < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :contents_html, :text
  end
end
