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
    
    @State private var isValidCity: Bool = true // To track if the city is valid or not

    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Color.clear.frame(height: 44)
                
                //Search
                VStack {
                    Text("SEARCH")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)

                    TextField("Enter location e.g. Dublin, IE", text: $cityName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        .onSubmit {
                            Task {
                                await checkCityAndFetchWeather()
                            }
                        }
                    
                }
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                
                // Called info!
                if !isValidCity {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916))
                        .padding(.horizontal)
                    
                    Text("Invalid Location, please try a new one")
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                } else {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916))
                        .padding(.horizontal)
                }
                
            }
        }
        .padding(.horizontal) // Apply default padding to the horizontal edges only
        .background(Color(red: 0.941, green: 0.949, blue: 0.966))
        .edgesIgnoringSafeArea(.top) // This will allow the content to go behind the dynamic island
    }
    
    private func checkCityAndFetchWeather() async {
        isValidCity = true
        
        // assume it's not empty
        guard !cityName.isEmpty else{
            isValidCity = false
            return
        }
        // why cannot you say if cityName.isEmpty { isValidCity = false }?
        // this guard logic is bit double denial, too complex
        
        do {
            let weatherData = try await weatherManager.getCurrentWeather(city: cityName)
            self.weather = weatherData
        } catch {
            isValidCity = false
        }
    }
}

#Preview {
    WeatherView()
}
