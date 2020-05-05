class ChangeOrdersName < ActiveRecord::Migration[5.2]
  def change
    execute 'DELETE FROM orders;'
    remove_column :orders, :description, :string
    remove_column :orders, :name, :string

    add_column :orders, :child_name, :string, null: false
    add_column :orders, :ruby_name, :string
    add_column :orders, :need_ruby, :boolean, default: false
    add_column :orders, :need_space, :boolean, default: false
    add_column :orders, :thread_color, :string, null: false
    add_column :orders, :font_name, :string, null: false
    add_column :orders, :working_flag, :boolean, default: false
    add_column :orders, :finished_flag, :boolean, default: false
  end
end
