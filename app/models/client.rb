class Client < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :dob
  validates :firstname, :presence => true
  validates :lastname, :presence => true
end
