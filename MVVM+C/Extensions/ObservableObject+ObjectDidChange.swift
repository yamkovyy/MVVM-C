//
//  ObservableObject+ObjectDidChange.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

import Combine

extension ObservableObject {
    /// A publisher that emits after the object has changed.
    /// - Parameter scheduler: The scheduler that is used to debounce the objectWillChange events.
    func objectDidChange(on scheduler: some Scheduler) -> AnyPublisher<Self.ObjectWillChangePublisher.Output, Never> {
        objectWillChange
            .debounce(for: 0, scheduler: scheduler)
            .eraseToAnyPublisher()
    }
}
