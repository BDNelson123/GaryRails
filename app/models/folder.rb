class Folder < ActiveRecord::Base
  attr_accessible :member_id, :client_id, :name

  belongs_to :client
  has_many :documents

  validates :name, :presence => true
end
