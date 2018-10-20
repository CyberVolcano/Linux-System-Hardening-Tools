import requests, json

send_url = 'http://freegeoip.net/json'

#sends request
r = requests.get(send_url)
j = json.loads(r.text)
#picks up data
lat = j['latitude']
lon = j['longitude']
country = j['country_name']
city = j['city']
time_zone = j['time_zone']
zipcode = j['zip_code']

#summary
print(lat)
print(lon)
print(country)
print(city)
print(time_zone)
print(zipcode)
