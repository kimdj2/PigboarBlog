class AddCategoriesToBoards < ActiveRecord::Migration[5.1]
  def change
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_reference :boards, :categories, foreign_key: true
  end
end
