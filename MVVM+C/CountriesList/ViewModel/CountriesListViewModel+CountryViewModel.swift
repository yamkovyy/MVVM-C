//
//  CountriesListViewModel+CountryViewModel.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

extension CountriesListViewModel {
    struct CountryViewModel: CountryTableViewCellViewModel, Hashable {
        let primaryTitle: String
        let secondaryTitle: String
        let subTitle: String
        let accessory: String
    }
}
