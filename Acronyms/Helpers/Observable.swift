//
//  Observable.swift
//  Acronyms
//
//  Created by Anusha G on 10/27/21.
//

import Foundation

class Observable<T> {
    var value: T? {
        didSet {
            listener.forEach {
                $0(value)
            }
        }
    }
    init(_ value: T?) {
        self.value = value
    }
    private var listener: [((T?) -> Void)] = []

    

    func bind(_ closure: @escaping (T?) -> Void) {
        closure(value)
        self.listener.append(closure)
    }
}
