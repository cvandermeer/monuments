class Rijksmonumenten
  include HTTParty
  base_uri 'api.rijksmonumenten.info'

  def self.search(query)
    response = get('/select/',  {query: { q: query, wt: 'json'}})
    data = JSON.parse(response.body)
    data['response']['docs'].each do |jsonlocation|
      location = Location.new
      location.title = jsonlocation['abc_objectnaam']
      location.street = jsonlocation['abc_adres']
      location.image = jsonlocation['abc_image_url']
      location.save
    end
  end
end
# Rijksmonumenten.search('oldehove')['response']['docs'].first