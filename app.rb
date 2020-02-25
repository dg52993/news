require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "YOUR-API-KEY"

get "/" do
    # show a view that asks for the location
    view "ask"
end

get "/news" do
        url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=yourkey"
    news = HTTParty.get(url).parsed_response.to_hash
    results = Geocoder.search(params["q"])
    lat_long = results.first.coordinates # => [lat,long]
    lat = lat_long[0]
    long = lat_long[1]
    "#{lat_long[0]} #{lat_long[1]}"

    

    # news is now a Hash you can pretty print (pp) and parse for your output
    # do everything else
end