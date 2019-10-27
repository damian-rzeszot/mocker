//
//  URLRequest.swift
//  Imitate
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import Foundation

internal extension URLRequest {

    func matches(_ string: String) -> Bool {
        return url!.matches(string)
    }

}
