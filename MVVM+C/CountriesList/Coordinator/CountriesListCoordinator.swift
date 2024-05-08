//
//  CountriesListCoordinator.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

import Combine
import UIKit

final class CountriesListCoordinator: Coordinator {
    typealias CompletionType = Void
    
    private weak var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start(animated: Bool) -> CompletionPublisher {
        let useCase = FetchCountriesUseCase()
        let viewModel = CountriesListViewModel(fetchCountriesUseCase: useCase)
        let viewController = CountriesListViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: animated)
        
        return .never()
    }
}
