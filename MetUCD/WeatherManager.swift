//
//  WeatherManager.swift
//  MetUCD
//
//  Created by Miaomiao Shi on 22/11/2023.
//

// WeatherViewModel
// interact with the ModelData(WeatherDataModel) and the WeatherView.
// fetch weather data from the OpenWeather API, handle any data processing or conversion (like converting temperature units), and prepare the data to be displayed in the view.

import Foundation

// Define a custom error type for weather-related errors
enum WeatherError: Error {
    case badURL          // Represents an error for an invalid URL
    case serverError     // Represents an error for any server-side issues or network problems
    case decodingError   // Represents an error when decoding the JSON response fails
}

class WeatherManager {
    // Function to fetch current weather data from the OpenWeather API
    func getCurrentWeather(city cityName: String) async throws -> ResponseBody {
        // Constructing the URL string
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=8b75a684ffe1eab191d21598865bb79d&units=metric"

        // Ensure the URL is valid, throw a badURL error if not
        guard let url = URL(string: urlString) else {
            throw WeatherError.badURL
        }
        
        // Attempt to fetch data from the server
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))

        // Check for a successful response (status code 200), throw a serverError otherwise
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw WeatherError.serverError
        }
        
        do {
            // Attempt to decode the JSON response into the ResponseBody structure
            let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
            return decodedData
        } catch {
            // If decoding fails, throw a decodingError
            print("decoding fails, struct wrong")
            throw WeatherError.decodingError
        }

    }
}

// Model of the response body we get from calling the OpenWeather API

struct ResponseBody: Decodable {
    var name: String
    var coord: CoordResponse
    var weather: [WeatherResponse]
    var sys: SysResponse
    var timezone: Double
    var main: MainResponse
    var wind: WindResponse
    var clouds: CloudsResponse

    struct CoordResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct SysResponse: Decodable {
        var sunrise: Double
        var sunset: Double
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
        var gust: Double
    }
    
    struct CloudsResponse: Decodable {
        var all: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
}



