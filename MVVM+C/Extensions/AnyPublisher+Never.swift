//
//  AnyPublisher+Never.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

import Combine

extension AnyPublisher {
    static func never() -> Self {
        Empty(completeImmediately: false).eraseToAnyPublisher()
    }
}
