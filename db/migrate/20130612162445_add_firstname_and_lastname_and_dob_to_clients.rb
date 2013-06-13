class AddFirstnameAndLastnameAndDobToClients < ActiveRecord::Migration
  def change
    add_column :clients, :firstname, :string
    add_column :clients, :lastname, :string
    add_column :clients, :dob, :string
  end
end
