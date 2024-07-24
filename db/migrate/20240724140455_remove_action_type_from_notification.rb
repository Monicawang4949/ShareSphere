class RemoveActionTypeFromNotification < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :action_type, :integer
  end
end
