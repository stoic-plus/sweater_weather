# Sweater Weather (API)

Backend to a Rails weather app. Each endpoint returns JSON (courtesy of fast_jsonapi).
Retrieves weather forecast (current, hourly, and daily) and just current from DarkSky API.
Also provides endpoints to return a background image for a location and GIPHS! Giphs that correspond to the weather for each day in the following week mind you.

### Table of Contents

- [Getting Started](#getting-started)
- [Endpoints](#endpoints)
  * [City Forecast](#city-forecast)
  * [Account Creation](#account-creation)
  * [Session Creation](#session-creation)
  * [Favorites Creation](#favorites-creation)
  * [Favorites Deletion](#favorites-deletion)
  * [Favorites Listing](#favorites-listing)
  * [Background Image](#background-image)
  * [Giphs!](#giphs!)
- [Built With](#built-with)
- [Built By](#built-by)


__Overview__

Provides two endpoints for user functionality of the app
* login (returning api_key given email/password)
* account creation (creating user and returning api_key)

Provides "favoriting" functionality through three endpoints.
* Creating a favorite
* Deleting a favorite
* Listing all favorites

A _favorite_ consists of the location and it's current weather.


## Getting Started

### Installing

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

### Running Test Suite

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


## Endpoints

#### Base Url

`https://still-brushlands-57488.herokuapp.com`


#### City Forecast

`GET /api/v1/forecast?location=denver,co`
  * required body parameters: `{location}`
    * must be formatted like: `city,STATE_ABREV` with comma to separate values
    * city can contain spaces
  * Returns forecast
    * Current weather
    * Hourly weather - next 48 hours,
    * Daily weather - today and next 7 days,
    * Today's high (°F)
    * Today's low (°F)
    * Summary for today's and tonight's weather

<details><summary>Example Request:</summary>

```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

</details>

<details><summary>Example Response:</summary>

```
{
    "data": {
        "id": "0",
        "type": "forecast",
        "attributes": {
            "currently": {
                "summary": "Clear",
                "icon": "clear-day",
                "precipProbability": 0,
                "humidity": 0.33,
                "uvIndex": 6,
                "time": 1552245570,
                "temperature": 47.13,
                "apparentTemperature": 46.14,
                "pressure": 1012.85,
                "visibility": 8.92,
                "ozone": 325.78,
                "nearestStormDistance": 2,
                "nearestStormBearing": 154
            },
            "hourly_forecast": [
                {
                    "summary": "Clear",
                    "icon": "clear-day",
                    "precipProbability": 0,
                    "humidity": 0.34,
                    "uvIndex": 5,
                    "time": 1552244400,
                    "temperature": 46.23,
                    "apparentTemperature": 46.23,
                    "pressure": 1013.08,
                    "visibility": 8.4,
                    "ozone": 326.18
                },
                {
                    "summary": "Partly Cloudy",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0.02,
                    "humidity": 0.3,
                    "uvIndex": 2,
                    "time": 1552255200,
                    "temperature": 51.74,
                    "apparentTemperature": 51.74,
                    "pressure": 1012.64,
                    "visibility": 10,
                    "ozone": 323.18
                },

                {
                    "summary": "Partly Cloudy",
                    "icon": "partly-cloudy-night",
                    "precipProbability": 0.02,
                    "humidity": 0.42,
                    "uvIndex": 0,
                    "time": 1552266000,
                    "temperature": 46.29,
                    "apparentTemperature": 42.77,
                    "pressure": 1014.96,
                    "visibility": 10,
                    "ozone": 323.03
                },
                ... etc
            ],
            "daily_forecast": [
                {
                    "summary": "Partly cloudy throughout the day.",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0.06,
                    "humidity": 0.53,
                    "uvIndex": 5,
                    "time": 1552201200,
                    "precipType": "rain",
                    "temperatureHigh": 51.74,
                    "temperatureLow": 26.39,
                    "apparentTemperatureHigh": 51.74,
                    "apparentTemperatureLow": 23.71,
                    "temperatureMin": 23.8,
                    "temperatureMax": 51.74,
                    "apparentTemperatureMax": 51.74,
                    "apparentTemperatureMin": 23.8
                },
                {
                    "summary": "Partly cloudy throughout the day.",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0.09,
                    "humidity": 0.65,
                    "uvIndex": 4,
                    "time": 1552284000,
                    "precipType": "rain",
                    "temperatureHigh": 50.85,
                    "temperatureLow": 31.42,
                    "apparentTemperatureHigh": 50.85,
                    "apparentTemperatureLow": 28,
                    "temperatureMin": 26.39,
                    "temperatureMax": 50.85,
                    "apparentTemperatureMax": 50.85,
                    "apparentTemperatureMin": 23.71
                },
                {
                    "summary": "Mostly cloudy throughout the day.",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0.22,
                    "humidity": 0.56,
                    "uvIndex": 4,
                    "time": 1552370400,
                    "precipType": "rain",
                    "temperatureHigh": 60.08,
                    "temperatureLow": 39.06,
                    "apparentTemperatureHigh": 60.08,
                    "apparentTemperatureLow": 32.62,
                    "temperatureMin": 31.42,
                    "temperatureMax": 60.08,
                    "apparentTemperatureMax": 60.08,
                    "apparentTemperatureMin": 28
                },
                {
                    "summary": "Snow (1–2 in.) and breezy starting in the afternoon, continuing until evening.",
                    "icon": "snow",
                    "precipProbability": 0.64,
                    "humidity": 0.74,
                    "uvIndex": 4,
                    "time": 1552456800,
                    "precipType": "rain",
                    "temperatureHigh": 39.38,
                    "temperatureLow": 26.91,
                    "apparentTemperatureHigh": 33.79,
                    "apparentTemperatureLow": 16.32,
                    "temperatureMin": 30.15,
                    "temperatureMax": 44.62,
                    "apparentTemperatureMax": 42.82,
                    "apparentTemperatureMin": 19.42
                },
                {
                    "summary": "Mostly cloudy throughout the day.",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0.21,
                    "humidity": 0.59,
                    "uvIndex": 3,
                    "time": 1552543200,
                    "precipType": "snow",
                    "temperatureHigh": 35.58,
                    "temperatureLow": 21.68,
                    "apparentTemperatureHigh": 26.77,
                    "apparentTemperatureLow": 13.61,
                    "temperatureMin": 26.91,
                    "temperatureMax": 35.58,
                    "apparentTemperatureMax": 26.77,
                    "apparentTemperatureMin": 16.32
                },
                {
                    "summary": "Mostly cloudy starting in the afternoon.",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0,
                    "humidity": 0.46,
                    "uvIndex": 5,
                    "time": 1552629600,
                    "precipType": null,
                    "temperatureHigh": 45.49,
                    "temperatureLow": 25.82,
                    "apparentTemperatureHigh": 41.72,
                    "apparentTemperatureLow": 25.53,
                    "temperatureMin": 21.68,
                    "temperatureMax": 45.49,
                    "apparentTemperatureMax": 41.72,
                    "apparentTemperatureMin": 13.61
                },
                {
                    "summary": "Mostly cloudy until afternoon.",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0.05,
                    "humidity": 0.53,
                    "uvIndex": 5,
                    "time": 1552716000,
                    "precipType": "snow",
                    "temperatureHigh": 43.15,
                    "temperatureLow": 28.3,
                    "apparentTemperatureHigh": 38.58,
                    "apparentTemperatureLow": 24.06,
                    "temperatureMin": 25.82,
                    "temperatureMax": 43.15,
                    "apparentTemperatureMax": 38.58,
                    "apparentTemperatureMin": 25.53
                },
                {
                    "summary": "Mostly cloudy starting in the afternoon.",
                    "icon": "partly-cloudy-night",
                    "precipProbability": 0.04,
                    "humidity": 0.44,
                    "uvIndex": 6,
                    "time": 1552802400,
                    "precipType": "rain",
                    "temperatureHigh": 54.72,
                    "temperatureLow": 29.38,
                    "apparentTemperatureHigh": 54.72,
                    "apparentTemperatureLow": 27.29,
                    "temperatureMin": 28.3,
                    "temperatureMax": 54.72,
                    "apparentTemperatureMax": 54.72,
                    "apparentTemperatureMin": 24.06
                }
            ],
            "today_high": 51.74,
            "today_low": 26.39,
            "today_summary": "Partly cloudy starting later this afternoon, continuing until tomorrow afternoon.",
            "tonight_summary": "Partly cloudy throughout the day."
        }
    }
}
```

</details>

<br>

#### Account Creation

`POST /api/v1/users`
* required parameters: `{email, password, password_confirmation}`


<details><summary>Example Request:</summary>

```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
  "password_confirmation": "password"
}
```

</details>


<details><summary>Example Response:</summary>

```
{
    "data": {
        "id": "0",
        "type": "users",
        "attributes": {
            "api_key": "3csdfhg546sdfmm67gd4ac7f4"
        }
    }
}
```

</details>

<br>

#### Session Creation

`POST /api/v1/sessions`
* required parameters: `{email, password}`


<details><summary>Example Request:</summary>

```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```

</details>


<details><summary>Example Response:</summary>

```
{
    "data": {
        "id": "0",
        "type": "sessions",
        "attributes": {
            "api_key": "3csdfhg546sdfmm67gd4ac7f4"
        }
    }
}
```

</details>


#### Favorites Creation

`POST /api/v1/favorites`
* required parameters: `{location, api_key}`
* city or state can be uppercase but state must be abbreviation
  * city can contain space

<details><summary>Example Request:</summary>

```
POST /api/v1/favorites
Content-Type: application/json
Accept: application/json

{
  "location": "Denver, CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

</details>


<details><summary>Example Response:</summary>

```
{
    "data": {
        "id": "3",
        "type": "api_message",
        "attributes": {
            "message": "successfully created favorite",
            "favorite": {
                "id": 2,
                "location": "Denver,CO",
                "current_weather": {
                    "summary": "Partly Cloudy",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0,
                    "humidity": 0.33,
                    "uvIndex": 4,
                    "time": 1552252022,
                    "temperature": 49.14,
                    "apparentTemperature": 46.41,
                    "pressure": 1011.81,
                    "visibility": 7.82,
                    "ozone": 323.83,
                    "nearestStormDistance": 1,
                    "nearestStormBearing": 295
                }
            }
        }
    }
}
```

</details>

<br>

#### Favorites Deletion

`DELETE /api/v1/favorites`
* required parameters: `{location, api_key}`
* same rules with city and state

<details><summary>Example Request:</summary>

```
DELETE /api/v1/favorites
Content-Type: application/json
Accept: application/json

{
  "location": "Denver, CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

</details>


<details><summary>Example Response:</summary>

```
{
    "data": {
        "id": "4",
        "type": "api_message",
        "attributes": {
            "message": "successfully deleted favorite",
            "favorite": {
                "id": 7,
                "location": "Denver,CO",
                "current_weather": {
                    "summary": "Partly Cloudy",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0,
                    "humidity": 0.33,
                    "uvIndex": 4,
                    "time": 1552252022,
                    "temperature": 49.14,
                    "apparentTemperature": 46.41,
                    "pressure": 1011.81,
                    "visibility": 7.82,
                    "ozone": 323.83,
                    "nearestStormDistance": 1,
                    "nearestStormBearing": 295
                }
            }
        }
    }
}
```

</details>

<br>

#### Favorites Listing

`GET /api/v1/favorites`
* required parameters: `{api_key}`
* same rules with city and state

<details><summary>Example Request:</summary>

```
GET /api/v1/favorites
Content-Type: application/json
Accept: application/json

{
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

</details>


<details><summary>Example Response:</summary>

```
{
    "data": [
        {
            "id": "21",
            "type": "favorites",
            "attributes": {
                "location": "Denver,CO",
                "current_weather": {
                    "summary": "Partly Cloudy",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0,
                    "humidity": 0.33,
                    "uvIndex": 4,
                    "time": 1552252022,
                    "temperature": 49.14,
                    "apparentTemperature": 46.41,
                    "pressure": 1011.81,
                    "visibility": 7.82,
                    "ozone": 323.83,
                    "nearestStormDistance": 1,
                    "nearestStormBearing": 295
                }
            }
        },
        {
            "id": "22",
            "type": "favorites",
            "attributes": {
                "location": "Boulder,CO",
                "current_weather": {
                    "summary": "Mostly Cloudy",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0,
                    "humidity": 0.4,
                    "uvIndex": 3,
                    "time": 1552252598,
                    "temperature": 45,
                    "apparentTemperature": 41.8,
                    "pressure": 1013.89,
                    "visibility": 5.99,
                    "ozone": 326.69,
                    "nearestStormDistance": 1,
                    "nearestStormBearing": 250
                }
            }
        },
        {
            "id": "23",
            "type": "favorites",
            "attributes": {
                "location": "Encinitas,CA",
                "current_weather": {
                    "summary": "Partly Cloudy",
                    "icon": "partly-cloudy-day",
                    "precipProbability": 0,
                    "humidity": 0.56,
                    "uvIndex": 4,
                    "time": 1552252633,
                    "temperature": 57.59,
                    "apparentTemperature": 57.59,
                    "pressure": 1013.84,
                    "visibility": 9.1,
                    "ozone": 375.49,
                    "nearestStormDistance": 30,
                    "nearestStormBearing": 294
                }
            }
        }
    ]
}
```

</details>

<br>


#### Background Image

`GET /api/v1/backgrounds`
* required parameters: `{location}`
* same rules with city and state

<details><summary>Example Request:</summary>

```
GET /api/v1/backgrounds
Content-Type: application/json
Accept: application/json

{
  "location": "denver,co"
}
```

</details>

<details><summary>Example Response:</summary>

```
{
    "data": {
        "id": "1",
        "type": "background",
        "attributes": {
            "id": 1,
            "location": "denver,co",
            "photo_url": "https://farm3.staticflickr.com/2894/10889430314_a5a49ab108.jpg"
        }
    }
}
```

</details>

<br>

#### GIPHS!

`GET /api/v1/gifs`
* required parameters: `{location}`
* same rules with city and state
* giphs for the next week that correspond to weather summary of each day
  * returns various giph links for use in development

<details><summary>Example Request:</summary>

```
GET /api/v1/gifs
Content-Type: application/json
Accept: application/json

{
  "location": "denver,co"
}
```

</details>

<details><summary>Example Response:</summary>

```
{
    "data": [
        {
            "id": "0",
            "type": "weather_gif",
            "attributes": {
                "time": 1552201200,
                "summary": "Partly cloudy starting in the evening.",
                "gif": {
                    "search_string": "partly-cloudy-night",
                    "embed_url": "https://giphy.com/embed/1uLQUtPLbJMQ0",
                    "looping": "https://media1.giphy.com/media/1uLQUtPLbJMQ0/giphy-loop.mp4",
                    "original_url": "https://media1.giphy.com/media/1uLQUtPLbJMQ0/giphy.gif"
                }
            }
        },
        {
            "id": "1",
            "type": "weather_gif",
            "attributes": {
                "time": 1552284000,
                "summary": "Partly cloudy throughout the day.",
                "gif": {
                    "search_string": "partly-cloudy-day",
                    "embed_url": "https://giphy.com/embed/1uLQUtPLbJMQ0",
                    "looping": "https://media3.giphy.com/media/1uLQUtPLbJMQ0/giphy-loop.mp4",
                    "original_url": "https://media3.giphy.com/media/1uLQUtPLbJMQ0/giphy.gif"
                }
            }
        },
        {
            "id": "2",
            "type": "weather_gif",
            "attributes": {
                "time": 1552370400,
                "summary": "Mostly cloudy throughout the day.",
                "gif": {
                    "search_string": "partly-cloudy-day",
                    "embed_url": "https://giphy.com/embed/aQ7kognlRPDzi",
                    "looping": "https://media3.giphy.com/media/aQ7kognlRPDzi/giphy-loop.mp4",
                    "original_url": "https://media3.giphy.com/media/aQ7kognlRPDzi/giphy.gif"
                }
            }
        },
        {
            "id": "3",
            "type": "weather_gif",
            "attributes": {
                "time": 1552456800,
                "summary": "Snow (1–2 in.) and breezy starting in the afternoon, continuing until evening.",
                "gif": {
                    "search_string": "snow",
                    "embed_url": "https://giphy.com/embed/l2JIaYp6P3WT5Ybu0",
                    "looping": "https://media0.giphy.com/media/l2JIaYp6P3WT5Ybu0/giphy-loop.mp4",
                    "original_url": "https://media0.giphy.com/media/l2JIaYp6P3WT5Ybu0/giphy.gif"
                }
            }
        },
        ...
    ]
 }
```

</details>

<br>

## Built With


* [DarkSky](https://darksky.net/dev) - Used to get all weather data
* [GoogleMaps](https://cloud.google.com/maps-platform/) - Used for geocoding
* [Flickr](https://www.flickr.com/services/apps/create/) - Used to get background images
* [Giphy](https://developers.giphy.com/) - Used to get giphs of current weather
* [Rspec](http://rspec.info/) - Testing Framework
* [fast_jsonapi](https://github.com/Netflix/fast_jsonapi) - JSON serializer for Ruby Objects

## Built By

* **Ricardo Ledesma** - [Personal Website](https://www.ricardoledesma.tech/)
