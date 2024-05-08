//
//  CountryTableViewCell.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

import UIKit

protocol CountryTableViewCellViewModel {
    var primaryTitle: String { get }
    var secondaryTitle: String { get }
    var subTitle: String { get }
    var accessory: String { get }
}

final class CountryTableViewCellView: UITableViewCell {
    static let reuseIdentifier: String = "CountryTableViewCellView"
}

extension CountryTableViewCellView: Configurable {
    func configure(with viewModel: CountryTableViewCellViewModel) {
        var config = defaultContentConfiguration()
        config.text = viewModel.primaryTitle + ", " + viewModel.secondaryTitle
        config.secondaryText = viewModel.subTitle
        
        let label = UILabel()
        label.text = viewModel.accessory
        label.sizeToFit()
        accessoryView = label
        
        contentConfiguration = config
    }
}
