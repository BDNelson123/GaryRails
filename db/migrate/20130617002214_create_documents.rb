class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :location
      t.integer :folder_id
      t.integer :client_id
      t.integer :member_id

      t.timestamps
    end
  end
end
