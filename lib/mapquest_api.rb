#mapquest integration
require 'httparty'

class MapquestApi
 
  API_URL = 'http://www.mapquestapi.com/directions/v2/routematrix?key=n52JE0HWCxZyrzGMaChQzGDHahE2juhS&allToAll=false'

  def post_url(from, to)
  	API_URL << "&from=#{CGI::escape(from)}&to=#{CGI::escape(to)}"
    response = HTTParty.post(API_URL)
    # TODO more error checking (500 error, etc)
    json = JSON.parse(response.body)
    # json['url']
    # puts YAML::dump(json)
    # puts YAML::dump(json['distance'][1])

    return json['distance'][1]

  end
end