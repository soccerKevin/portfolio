class CreateAuthenticates < ActiveRecord::Migration
  def change
    create_table :authenticates do |t|
      t.string :name
      t.string :password
      t.string :password_confirmation

      t.timestamps null: false
    end
  end
end
