# encoding: utf-8

class Idea < ActiveRecord::Base
  attr_accessible :title, :description, :address, :latitude, :longitude, :image, :remote_image_url
  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  has_reputation :votes, source: :user, aggregated_by: :sum
  
  validates_presence_of :title
  validates_presence_of :description
  validates :image,
    # presence: true,
    file_size: {
      maximum: 0.5.megabytes.to_i
    }
  
  def image_name
    File.basename(image.path || image.filename) if image
  end
  
  
  private
  
  def full_address
    self[:address].to_s + ", Wrocław, Poland"
  end
end
