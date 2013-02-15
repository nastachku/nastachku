class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :slug
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
