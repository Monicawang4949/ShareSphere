class AddActionTypeToNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :action_type, :integer
  end
end
