//
//  FetchCountriesResponse.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

import Foundation

struct Country: Decodable {
    let name: String
    let region: String
    let capital: String
    let code: String
}

extension CountriesListViewModel.CountryViewModel {
    init(country: Country) {
        self.primaryTitle = country.name
        self.secondaryTitle = country.region
        self.subTitle = country.capital
        self.accessory = country.code
    }
}
