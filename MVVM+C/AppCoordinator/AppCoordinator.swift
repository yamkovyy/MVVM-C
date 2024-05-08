//
//  AppCoordinator.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

import Combine
import UIKit

protocol Coordinator {
    associatedtype CompletionType
    typealias CompletionPublisher = AnyPublisher<CompletionType, Never>
    
    func start(animated: Bool) -> CompletionPublisher
}

final class AppCoordinator: Coordinator {
    typealias CompletionType = Void
    
    private let window : UIWindow
    private var childCoordinator: (any Coordinator)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    @discardableResult
    func start(animated: Bool) -> CompletionPublisher {
        let rootViewController = UINavigationController()
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        let coordinator = CountriesListCoordinator(navigationController: rootViewController)
        coordinator.start(animated: false)
        
        return .never()
    }
}
