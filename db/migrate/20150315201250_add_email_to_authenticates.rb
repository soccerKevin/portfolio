class AddEmailToAuthenticates < ActiveRecord::Migration
  def change
    add_column :authenticates, :email, :string
  end
end
