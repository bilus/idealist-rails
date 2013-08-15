class Idea < ActiveRecord::Base
  attr_accessible :title, :description, :address, :latitude, :longitude
end
