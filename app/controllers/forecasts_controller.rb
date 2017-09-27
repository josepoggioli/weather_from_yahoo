class ForecastsController < ApplicationController

  def index

    if params[:city] && params[:state]
      city = params[:city]
      state = params[:state]
    else
      city = "San Diego"
      state = "CA"
    end

    @forecast = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{city}%2C%20#{state}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body

    @city_name = @forecast['query']['results']['channel']['location']['city']
    @state_name = @forecast['query']['results']['channel']['location']['region']  

    
    @current_temp = @forecast['query']['results']['channel']['item']['condition']['temp']
    @temp_unit = @forecast['query']['results']['channel']['units']['temperature']
    @five_forecast = @forecast['query']['results']['channel']['item']['forecast']
  end

end
