//
//  ContentView.swift
//  EUCountriesApp
//
//  Created by Ramesh Pandey on 26.6.2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = CountryViewModel()

    var body: some View {
        VStack(spacing: 20) {
            
                Text("Welcome :) to the InfoEUApp")
                    .foregroundColor(.blue)
                    .font(.title)
                    .padding(.top, 32)
                
            HStack {
                Text("Select Country:")
                    .font(.headline)

                Picker("", selection: $viewModel.selectedCountry) {
                    ForEach(viewModel.countries, id: \.self) { country in
                        Text(country.name.common).tag(Optional(country))
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }

            if let country = viewModel.selectedCountry {
                VStack(alignment: .leading, spacing: 10) {
                    
                    if let flagURL = country.flags.png,
                       let url = URL(string: flagURL) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                 .scaledToFit()
                                 .border(Color.black, width: 1)
                                 .frame(width: 180)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    Text("Country: ") .bold() + Text("\(country.name.common)")
                    Text("Capital: ") .bold() + Text(" \(country.capital?.first ?? "N/A")")
                    
                    Text("Population: ") .bold() + Text(" \(country.population)")
                    Text("Area: ") .bold() + Text(" \(Int(country.area)) km²")

                    if let currency = country.currencies?.first?.value {
                        Text("Currency: ") .bold() + Text(" \(currency.name ?? "") (\(currency.symbol ?? ""))")
                    }

                    if let language = country.languages?.first?.value {
                        Text("Main Language: ") .bold() + Text(" \(language)")
                    }
                    
                    if let mapsURL = country.maps?.googleMaps, let url = URL(string: mapsURL) {
                        Link("View in Google Maps", destination: url)
                            .foregroundColor(.blue)
                            .underline()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchCountries()
        }
    }

}
