class ChangeOrdersNameNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :orders, :name, false
  end
end
