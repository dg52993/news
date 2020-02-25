require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "fbf325927771eea4ca546f17b9745f5a"


get "/" do
    #show a view that asks for the location
    view "ask"
end

get "/news" do   
    results = Geocoder.search(params["q"])
    lat_long = results.first.coordinates # => [lat,long]
    lat = lat_long[0]
    long = lat_long[1]
    "#{lat_long[0]} #{lat_long[1]}"
    @forecast = ForecastIO.forecast(lat, long).to_hash
    
    url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=653fd3f177fc455a942f8292bf6a1650"
    @news = HTTParty.get(url).parsed_response.to_hash
    view "news"
end