import Combine
import SwiftUI

typealias CancelBag = Set<AnyCancellable>

extension CurrentValueSubject {
    subscript<T>(_ path: WritableKeyPath<Output, T>) -> T where T: Equatable {
        get { value[keyPath: path] }
        set {
            var value = self.value
            if value[keyPath: path] != newValue {
                value[keyPath: path] = newValue
                self.value = value
            }
        }
    }

    func set(_ update: (inout Output) -> Void) {
        var value = self.value
        update(&value)
        self.value = value
    }

    func get<Value>(_ path: KeyPath<Output, Value>) ->
        AnyPublisher<Value, Failure> where Value: Equatable {
        return map(path).removeDuplicates().eraseToAnyPublisher()
    }
}

extension Binding where Value: Equatable {
    func share<State>(with state: CurrentValueSubject<State, Never>, _ path: WritableKeyPath<State, Value>) -> Self {
        return onSet { state[path] = $0 }
    }
}

extension Binding where Value: Equatable {    
    func onSet(_ perform: @escaping (Value) -> Void) -> Self {
        return .init(get: { () -> Value in
            self.wrappedValue
        }, set: { value in
            if self.wrappedValue != value {
                self.wrappedValue = value
            }
            perform(value)
        })
    }
}

extension Publisher where Failure == Never {
    func weaklyAssign<T: AnyObject>(
        to object: T, _ keyPath: ReferenceWritableKeyPath<T, Output>
    ) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
