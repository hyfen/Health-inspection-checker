# Foursquare <-> Dinesafe

This app grabs your foursquare checkin history and checks which of your favourite venues in Toronto have failed their health inspections.

## Setting up Foursquare authentication

You must register the app on [Foursquare's developer site](https://foursquare.com/oauth/register). For the callback url, use <code>[RAILS_ROOT]/oauth/callback</code>. Once you have a <code>client_id</code> and <code>client_secret</code>, put them in <code>config/foursquare.yml</code>. These variables will now be available through the <code>APP_CONFIG</code> variable. 

## Where to get the Dinesafe data

Archives of Dinesafe health inspections are available on [Toronto's Open Data site](http://www.toronto.ca/open/datasets/dinesafe/). 

### Converting the XML dumps to SQL

The data comes in the form of gigantic XML dumps from Dinesafe's own databases. A conversion script is available in <code>script/dinesafe-xml2csv.rb</code>. It spits out three CSV files representing establishments, inspections, and infractions.

### Future plans?

[Dinesafe's official web](http://app.toronto.ca/food2/index.jsp) site has up-to-date information on health inspections as they happen. Instead of waiting for reports to get archived and posted to Toronto.ca/open, a scraper could allow this app to include much more recent results.

## Geocoding

Using the address column in the <code>Establishments</code> table, you can get coordinates for each restaurant. I opened up the CSV in Google Refine and added coordinates using [these instructions](http://code.google.com/p/google-refine/wiki/Geocoding). Make sure to add ",toronto,ontario" to the end of the query since the Dinesafe database only includes street address.

	"http://maps.google.com/maps/api/geocode/json?sensor=false&address=" + escape(value, "url") + ",toronto,ontario"

Google allows 2500 geocoding requests per day. The latest Dinesafe XML dump represents about 10,000 establishments so geocoding all of them will have to be done over a few days.

### Bonus: heat maps!

Once you have the addresses geocoded, you can turn the data into pretty heatmaps! Here's a map of where inspections have taken place downtown: 

![Dinesafe inspections as a heatmap](http://dl.dropbox.com/u/1144778/screencaps/cap_02222011_165645.png)


## Search

To match Foursquare venues and Dinesafe establishments, we use Sphinx. The crude solution is an index on the Establishment name and address columns and then searching for that in conjunction with the Foursquare venue name and address fields. It works 80% of the time. This needs improvement.

Make sure to run rake ts:config, ts:in, and then ts:start to configure, index, and start the Sphinx server.

## TODOs 

- better display of infractions for a venue
- better matching between Dinesafe establishments and Foursquare venues
- heat maps!