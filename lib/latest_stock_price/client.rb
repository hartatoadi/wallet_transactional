require 'net/http'
require 'json'

module LatestStockPrice
  class Client
    RAPIDAPI_HOST = 'latest-stock-price.p.rapidapi.com'
    BASE_URL = "https://#{RAPIDAPI_HOST}"
    RAPIDAPI_KEY = 'd528875edamsh085941bd6af5a47p1beffcjsneff51549439f' #Need dotenv / env variable for api key, will modify later

    def initialize
      raise 'RAPIDAPI_KEY environment variable not set' unless RAPIDAPI_KEY
    end

    def price_all
      request('/any')
    end

    private

    def request(endpoint)
      uri = URI("#{BASE_URL}#{endpoint}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      request['x-rapidapi-key'] = RAPIDAPI_KEY
      request['x-rapidapi-host'] = RAPIDAPI_HOST

      response = http.request(request)

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        raise "Error: #{response.code} - #{response.message}"
      end
    end
  end
end
