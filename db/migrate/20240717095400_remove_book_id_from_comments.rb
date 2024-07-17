class RemoveBookIdFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :book_id, :integer
  end
end
