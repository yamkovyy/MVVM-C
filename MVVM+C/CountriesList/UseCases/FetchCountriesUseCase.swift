//
//  FetchCountriesUseCase.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

import Combine
import Foundation

struct FetchCountriesUseCase: CountriesListViewModelUseCase {
    private let url: URL = .init(string: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json")!
    
    func fetchCountries() -> AnyPublisher<[CountriesListViewModel.CountryViewModel], Error> {
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [Country].self, decoder: JSONDecoder())
            .map { $0.map { CountriesListViewModel.CountryViewModel.init(country: $0)} }
            .eraseToAnyPublisher()
        
        return publisher
    }
}
