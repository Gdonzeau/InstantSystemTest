//
//  MockNetworkSession.swift
//  SwiftUIDependencyInjectionAsyncAwaitTests
//
//  Created by Guillaume on 22/07/2023.
//

import Foundation
@testable import InstantSystemSwiftUI

class MockNetworkSessionNet: NetworkInterface {
    private var urlSession: URLSession
    
    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    func fetchData(url: URL) async throws -> Data {
        if url == URL(string: "SendRightData")! {
            return FakeResponseData.NewsCorrectData
        } else if url == URL(string: "SendBadData")! {
            return FakeResponseData.NewsIncorrectData
        }
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkErrors.invalidStatusCode
        }
        return data
    }
}
