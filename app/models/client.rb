class Client < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :dob

  has_many :folders

  validates :firstname, :presence => true
  validates :lastname, :presence => true
end
