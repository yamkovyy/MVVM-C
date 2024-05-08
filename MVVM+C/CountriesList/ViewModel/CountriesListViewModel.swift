//
//  CountriesListViewModel.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

import Combine

protocol CountriesListViewModelUseCase {
    func fetchCountries() -> AnyPublisher<[CountriesListViewModel.CountryViewModel], Error>
}

final class CountriesListViewModel: CountriesListViewControllerViewModel {
    @Published var countries: [CountryViewModel] = []
    @Published var isLoading: Bool = false
    
    private let fetchCountriesUseCase: CountriesListViewModelUseCase
    
    private var originalCountriesList: [CountryViewModel] = [] {
        didSet {
            countries = originalCountriesList
        }
    }
    
    let error: PassthroughSubject<Error, Never> = .init()
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    init(fetchCountriesUseCase: CountriesListViewModelUseCase) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
    }
    
    func loadData() {
        guard !isLoading else { return }
        isLoading = true
        
        fetchCountriesUseCase
            .fetchCountries()
            .sink(receiveCompletion: { [weak self] result in
                self?.isLoading = false
                switch result {
                case let .failure(error):
                    self?.error.send(error)
                default:
                    break
                }
            }, receiveValue: { [weak self] countries in
                self?.originalCountriesList = countries
            })
            .store(in: &cancellables)
    }
    
    func userDidSearch(text: String?) {
        guard let text, !text.isEmpty else {
            countries = originalCountriesList
            return
        }
        countries = originalCountriesList.filter({ country in
            country.primaryTitle.contains(text) || country.subTitle.contains(text)
        })
    }
}

