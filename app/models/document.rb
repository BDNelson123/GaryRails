class Document < ActiveRecord::Base
  attr_accessible :name, :location, :client_id, :folder_id

  belongs_to :folder

  validates :name, :presence => true
end
