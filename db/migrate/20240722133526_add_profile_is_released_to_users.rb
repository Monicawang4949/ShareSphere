class AddProfileIsReleasedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile_is_released, :boolean, null: false, default: true
  end
end
