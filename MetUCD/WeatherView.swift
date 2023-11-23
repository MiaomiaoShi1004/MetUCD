//
//  ContentView.swift
//  MetUCD
//
//  Created by Miaomiao Shi on 22/11/2023.
//

import SwiftUI

struct WeatherView: View {
    // initiate weather manager
    var weatherManager = WeatherManager()
    // @State is for simple data that when changed, should cause the view to update
    @State var weather: ResponseBody?
    
    @State private var cityName: String = ""
    
    @State private var errorMessage: String = "" // To display error messages

    
    var body: some View {
        ScrollView {
            VStack(spacing: 20.0) {
                
                Color.clear.frame(height: 44)
                
                //Search
                VStack(spacing: 10) {
                    Text("SEARCH")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)

                    TextField("Enter location e.g. Dublin, IE", text: $cityName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )

                        .onSubmit {
                            Task {
                                await fetchWeather()
                            }
                        }
                }
                
                // Error Message Display
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                // Weather Data Display
                if let weatherData = weather {
                    
                    GrayLine()
                    // GEO INFO
                    VStack {
                        Heading(heading: "GEO INFO")
                        
                        
                        VStack(spacing: 10) {
                            VStack(spacing: 10) {
                                IconText(logo: "location", value: "\(weatherData.coord.lon.toDMS()), \(weatherData.coord.lat.toDMS())")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916)), alignment: .bottom
                            )
                            
                            HStack(spacing:0) {
                                HStack(spacing: 5) {
                                    IconText(logo: "sunrise", value: "\(weatherData.sys.sunrise.toTimeStringInLondon())")
                                    
                                    
                                    Text("(\(weatherData.sys.sunrise.toLocalTimeString(timezoneOffset: weatherData.timezone)))")
                                        .foregroundColor(Color(red: 0.692, green: 0.691, blue: 0.703))
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack(spacing: 5) {
                                    IconText(logo: "sunset", value: "\(weatherData.sys.sunset.toTimeStringInLondon())")
                                    
                                    Text("(\(weatherData.sys.sunset.toLocalTimeString(timezoneOffset: weatherData.timezone)))")
                                        .foregroundColor(Color(red: 0.692, green: 0.691, blue: 0.703))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916)), alignment: .bottom
                            )
                            
                            VStack(spacing: 10) {
                                IconText(logo: "clock.arrow.2.circlepath", value: "\(weatherData.timezone.formatTimeZone())")
                                    .frame(maxWidth: .infinity, alignment: .leading)

                            }
                            
                            
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        
                    }

                    
                    // WEATHER: FEW CLOUDS
                    VStack {
                        Heading(heading: "WEATHER: \(weatherData.weather[0].description.uppercased())")
                        
                        VStack(spacing: 10) {
                            HStack(spacing:0) {
                                HStack(spacing: 5) {
                                    IconText(logo: "thermometer.medium", value: String(format: "%.0f°", weatherData.main.feels_like))
                                    
                                    Text("(L: \(String(format: "%.0f°", weatherData.main.temp_min)) H: \(String(format: "%.0f°", weatherData.main.temp_max)))")
                                        .foregroundColor(Color(red: 0.692, green: 0.691, blue: 0.703))
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack(spacing: 5) {
                                    IconText(logo: "thermometer.variable.and.figure", value: "Feels \(String(format: "%.0f°", weatherData.main.feels_like))")
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916)), alignment: .bottom
                            )
                            
                            VStack(spacing: 10) {
                                IconText(logo: "cloud", value: "\(String(format: "%.0f%%", weatherData.clouds.all)) \(weatherData.weather[0].main)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916)), alignment: .bottom
                            )
                            
                            
                            VStack(spacing: 10) {
                                IconText(logo: "wind", value: "\(String(format: "%.1f km/h, dir: %.0f°", weatherData.wind.speed, weatherData.wind.deg))")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916)), alignment: .bottom
                            )
                            
                            HStack(spacing:10) {
                                IconText(logo: "humidity", value: String(format: "%.0f%%", weatherData.main.feels_like))
                                IconText(logo: "thermometer.sun.circle", value: "\(String(format: "%.0f hPa", weatherData.main.pressure))")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916)), alignment: .bottom
                            )
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        
                    }
                    
                    
                    // GEO INFO
                    VStack {
                        Heading(heading: "AIR QUALIFY")
                        
                        
                        VStack(spacing: 10) {
                            VStack(spacing: 10) {
                                IconText(logo: "location", value: "\(weatherData.coord.lon.toDMS()), \(weatherData.coord.lat.toDMS())")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916)), alignment: .bottom
                            )
                            
                            HStack(spacing:0) {
                                HStack(spacing: 5) {
                                    IconText(logo: "sunrise", value: "\(weatherData.sys.sunrise.toTimeStringInLondon())")
                                    
                                    
                                    Text("(\(weatherData.sys.sunrise.toLocalTimeString(timezoneOffset: weatherData.timezone)))")
                                        .foregroundColor(Color(red: 0.692, green: 0.691, blue: 0.703))
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack(spacing: 5) {
                                    IconText(logo: "sunset", value: "\(weatherData.sys.sunset.toTimeStringInLondon())")
                                    
                                    Text("(\(weatherData.sys.sunset.toLocalTimeString(timezoneOffset: weatherData.timezone)))")
                                        .foregroundColor(Color(red: 0.692, green: 0.691, blue: 0.703))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916)), alignment: .bottom
                            )
                            
                            VStack(spacing: 10) {
                                IconText(logo: "clock.arrow.2.circlepath", value: "\(weatherData.timezone.formatTimeZone())")
                                    .frame(maxWidth: .infinity, alignment: .leading)

                            }
                            
                            
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        
                    }
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    // GEO INFO
                    VStack {
                        Heading(heading: "GEO INFO")
                        
                        
                        VStack(spacing: 10) {
                            VStack(spacing: 10) {
                                IconText(logo: "location", value: "\(weatherData.coord.lon.toDMS()), \(weatherData.coord.lat.toDMS())")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916)), alignment: .bottom
                            )
                            
                            HStack(spacing:0) {
                                HStack(spacing: 5) {
                                    IconText(logo: "sunrise", value: "\(weatherData.sys.sunrise.toTimeStringInLondon())")
                                    
                                    
                                    Text("(\(weatherData.sys.sunrise.toLocalTimeString(timezoneOffset: weatherData.timezone)))")
                                        .foregroundColor(Color(red: 0.692, green: 0.691, blue: 0.703))
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack(spacing: 5) {
                                    IconText(logo: "sunset", value: "\(weatherData.sys.sunset.toTimeStringInLondon())")
                                    
                                    Text("(\(weatherData.sys.sunset.toLocalTimeString(timezoneOffset: weatherData.timezone)))")
                                        .foregroundColor(Color(red: 0.692, green: 0.691, blue: 0.703))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916)), alignment: .bottom
                            )
                            
                            VStack(spacing: 10) {
                                IconText(logo: "clock.arrow.2.circlepath", value: "\(weatherData.timezone.formatTimeZone())")
                                    .frame(maxWidth: .infinity, alignment: .leading)

                            }
                            
                            
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        
                    }
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)

                }
                
            }
        }
        .padding(.horizontal) // Apply default padding to the horizontal edges only
        .background(Color(red: 0.941, green: 0.949, blue: 0.966))
        .edgesIgnoringSafeArea(.top) // This will allow the content to go behind the dynamic island
    }
    
    // Function to fetch weather and handle errors
    private func fetchWeather() async {
        do {
            let weatherData = try await weatherManager.getCurrentWeather(city: cityName)
            self.weather = weatherData
            self.errorMessage = "" // Clear any previous error message
        } catch {
            // Handle errors and update errorMessage
            if let weatherError = error as? WeatherError {
                switch weatherError {
                case .badURL:
                    errorMessage = "Invalid location, please try a new one."
                case .serverError:
                    errorMessage = "Server error, please try again later."
                case .decodingError:
                    errorMessage = "Decoding wrong."
                }
            } else {
                errorMessage = "An unexpected error occurred."
            }
            self.weather = nil // Clear any previous weather data
        }
    }

}

#Preview {
//    WeatherView()
    WeatherView(weather: previewWeather)
}
