//
//  CancelBag.swift
//  
//
//  Created by Al-attar on 23/04/2025.
//

import Foundation
import Combine

/// An object that handle all Combine subscriptions. Similar as DisposeBag in RxSwift
public final class CancelBag {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()
    
    @resultBuilder
    public struct Builder {
        public static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
            return cancellables
        }
    }
    
    //MARK: - Initialization
    public init() {}
    
    deinit {
        cancel()
    }
    
    //MARK: - Methods
    public func cancel() {
        subscriptions.removeAll()
    }
    
    public func collect(@Builder _ cancellables: () -> [AnyCancellable]) {
        subscriptions.formUnion(cancellables())
    }
}

//MARK: - AnyCancellable
public extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
