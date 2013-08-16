# encoding: utf-8

class Idea < ActiveRecord::Base
  attr_accessible :title, :description, :address, :latitude, :longitude, :image, :remote_image_url
  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?
  mount_uploader :image, ImageUploader
  
  private
  
  def full_address
    self[:address].to_s + ", Wrocław, Poland"
  end
end
