class FixFoldersClientColumnName < ActiveRecord::Migration
  def up
    rename_column :folders, :clientid, :client_id
  end

  def down
    rename_column :folders, :client_id, :clientid
  end
end
