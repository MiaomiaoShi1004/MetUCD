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

class WeatherManager {

    // This function feteches the current weather data from the Openweather API using the provided city
    func getCurrentWeather(city cityName: String) async throws -> ResponseBody {
        
        //???stateName, countryName pending here
        guard let url = URL(string: "    https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=8b75a684ffe1eab191d21598865bb79d&units=metric") else { fatalError("Missing URL") }
        
        // creating a URL request object from the URL
        let urlRequest = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // check if the data has been sucessfully fetched
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

// Model of the response body we get from calling the OpenWeather API

struct ResponseBody: Decodable {
    var coord: CoordResponse
    var sys: SysResponse
    var timezone: TimezoneResponse
    
    struct CoordResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct SysResponse: Decodable {
        var sunrise: Double
        var sunset: Double
    }
    
    struct TimezoneResponse: Decodable {
        var timezone: Double
    }
}

