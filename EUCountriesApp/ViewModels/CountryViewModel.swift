//
//  CountryViewModel.swift
//  EUCountriesApp
//
//  Created by Ramesh Pandey on 26.6.2025.
//

import Foundation

class CountryViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var selectedCountry: Country? = nil
    
    func fetchCountries() {
        guard let url = URL(string: "https://restcountries.com/v3.1/region/europe") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                                    DispatchQueue.main.async {
                                        let sortedCountries = countries.sorted { $0.name.common < $1.name.common }
                                        self.countries = sortedCountries

                                        // ✅ Set default to "France" if available
                                        self.selectedCountry = sortedCountries.first(where: {
                                            $0.name.common.lowercased() == "france"
                                        }) ?? sortedCountries.first
                    
                        
                        print("✅ Countries fetched: \(countries.count)")
                    }
                } catch {
                    print("❌ Decoding error: \(error)")
                }
            } else if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
