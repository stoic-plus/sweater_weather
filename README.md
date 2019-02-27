# Sweater Weather (API)

Backend to a Rails weather app. Each endpoint returns JSON (courtesy of fast_jsonapi).
Retrieves weather forecast (current, hourly, and daily) and just current from DarkSky API.
Also provides endpoints to return a background image for a location and GIPHS! Giphs that correspond to the weather for each day in the following week mind you.

Provides two endpoints for user functionality of the app
* login (returning api_key given email/password)
* account creation (creating user and returning api_key)

Provides "favoriting" functionality through three endpoints.
* Creating a favorite
* Deleting a favorite
* Listing all favorites

A _favorite_ consists of the location and it's current weather.

## Getting Started

__Installing__

Run the following:
```
$ git clone https://github.com/stoic-plus/sweater_weather.git
$ bundle install
$ figaro install
```

Then you'll need to add 4 api keys to the generated `application.yaml` file under `/config`
in your root folder. Like so:

```
DARK_SKY_SECRET_KEY: sdfhg4354ghhkasdh4...
```

__Running Test Suite__

(After cloning down repo)

```
cd sweater_weather
rspec
```

### Prerequisites

You'll need the following:

__Software__
* Ruby (2.4.5)
* [Bundler](https://bundler.io/)


__Api Keys__

* [DarkSky](https://darksky.net/dev)
* [GoogleMaps](https://cloud.google.com/maps-platform/)
* [Flickr](https://www.flickr.com/services/apps/create/)
* [Giphy](https://developers.giphy.com/)


## Built With


* [DarkSky](https://darksky.net/dev) - Used to get all weather data
* [GoogleMaps](https://cloud.google.com/maps-platform/) - Used for geocoding
* [Flickr](https://www.flickr.com/services/apps/create/) - Used to get background images
* [Giphy](https://developers.giphy.com/) - Used to get giphs of current weather
* [Rspec](http://rspec.info/) - Testing Framework
* [fast_jsonapi](https://github.com/Netflix/fast_jsonapi) - JSON serializer for Ruby Objects

## Authors

* **Ricardo Ledesma** - [Personal Website](https://www.ricardoledesma.tech/)

## Acknowledgments

* Mike Dao
* Sal Espinosa
