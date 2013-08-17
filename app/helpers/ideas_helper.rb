module IdeasHelper
  def human_address(idea)
    if idea.address.blank?
      "Wrocław"
    else
      @idea.address 
    end
  end
  
  def map_url(idea, options = {})
    width = options[:width] || 400
    height = options[:height] || 400
    zoom = idea.address.blank? ? 13 : 16
    "http://maps.google.com/maps/api/staticmap?size=#{width}x#{height}&sensor=false&zoom=#{zoom}&markers=#{idea.latitude}%2C#{idea.longitude}"
  end
end
