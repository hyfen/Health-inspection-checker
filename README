# Foursquare <-> Dinesafe

This app grabs your foursquare checkin history and checks which of your favourite venues in Toronto have failed their health inspections.

## Setting up Foursquare authentication

To use this app, you must register on [Foursquare's developer site](https://foursquare.com/oauth/register). For the callback url, use <code>[RAILS_ROOT]/oauth/callback</code>. Once you have a client_id and client_secret, put them in config/foursquare.yml. These variables will be now available through the APP_CONFIG variable. 

## Where to get the Dinesafe data

Archives of Dinesafe health inspections are available on [Toronto's Open Data site](http://www.toronto.ca/open/datasets/dinesafe/). 

### Converting the XML dumps to SQL

The data comes in the form of gigantic XML dumps from Dinesafe's own databases. A conversion script is available in <code>script/dinesafe-xml2csv.rb</code>

### Future plans?

[Dinesafe's official web](http://app.toronto.ca/food2/index.jsp) site has up-to-date information on health inspections as they happen. Instead of waiting for reports to get archived and posted to Toronto.ca/open, a scraper could allow this app to include much more recent results.

## Geocoding

Using the address column in the <code>Establishments</code> table, you can get coordinates for each restaurant. I opened up the CSV in Google Refine and added coordinates using [these instructions](http://code.google.com/p/google-refine/wiki/Geocoding). Make sure to add ",toronto,ontario" to the end of the query since the Dinesafe database only includes street address.

	"http://maps.google.com/maps/api/geocode/json?sensor=false&address=" + escape(value, "url") + ",toronto,ontario"

Google allows 2500 geocoding requests per day. The latest Dinesafe XML dump represents about 10,000 establishments so geocoding all of them will take a few days.

## Search

To match foursquare venues and Dinesafe establishments, we use Sphinx. The crude solution is an index on Establishment's name and address columns and then searching for that in conjunction with the foursquare venue name and address fields. It works 80% of the time.

Make sure to run rake ts:config, ts:in, and then ts:start to configure, index, and start the Sphinx server.

## TODOs 

- handling user sessions
- better display of infractions for a venue
- better matching between Dinesafe establishments and Foursquare venues
- heat maps!