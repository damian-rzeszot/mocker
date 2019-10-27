//
//  Headers.swift
//  Imitate
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

public class Headers {

    // MARK: -

    internal private(set) var dictionary: [String: String] = [:]

    // MARK: -

    internal init() {

    }

    // MARK: -

    private func normalize(_ key: String) -> String {
        return key.lowercased()
    }

    // MARK: -

    public subscript(_ key: String) -> String? {
        get {
            return dictionary[normalize(key)]
        }
        set(value) {
            dictionary[normalize(key)] = value
        }
    }

    public var count: Int {
        return dictionary.count
    }

}
