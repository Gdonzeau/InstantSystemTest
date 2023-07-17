//
//  Extension String.swift
//  SwiftUI_HttpRequest
//
//  Created by Guillaume on 16/07/2023.
//

import Foundation

extension String? {
    func isHttpAdress() -> Bool {
        guard let potentialAddress = self else {
            return false
        }
        if potentialAddress.starts(with: "https") {
            return true
        }
        return false
    }
}
