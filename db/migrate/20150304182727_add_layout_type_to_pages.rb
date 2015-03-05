class AddLayoutTypeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :layout, :string, null: false, default: "application"
  end
end
