class AddUserIdToOrders < ActiveRecord::Migration[5.2]
  def up
      execute 'DELETE FROM orders;'
      add_reference :orders, :user, null: false, index: true
  end

  def down
    remove_reference :orders, :user, index: true
  end
end
