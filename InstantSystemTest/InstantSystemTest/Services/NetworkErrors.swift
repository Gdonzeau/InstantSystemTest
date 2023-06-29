//
//  NetworkErrors.swift
//  InstantSystemTest
//
//  Created by Guillaume on 29/06/2023.
//

import Foundation

enum NetworkErrors: String, Error {
    case noData = "There are no data"
    case noError = "There is no error." // For tests
    case decodingError = "Error while decoding"
    case invalidURL = "Not the right adress."
    case invalidStatusCode = "Invalid Status."
    case errorGenerated
    
}
