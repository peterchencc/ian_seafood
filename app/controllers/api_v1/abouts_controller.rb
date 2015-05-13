class ApiV1::AboutsController < ApiController
  
  def index
    @abouts = About.first
  end

end