//
//  Configurable.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

protocol Configurable {
    associatedtype ConfigurationItem
    func configure(with item: ConfigurationItem)
}
