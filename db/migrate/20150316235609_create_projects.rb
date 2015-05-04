class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :pic_url
      t.string :site_url
      t.string :categories
      t.text :technologies_used

      t.timestamps null: false
    end
  end
end
