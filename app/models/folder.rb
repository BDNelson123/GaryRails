class Folder < ActiveRecord::Base
  attr_accessible :member_id, :client_id, :name

  belongs_to :client

  validates :name, :presence => true
end
