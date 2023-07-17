//
//  Network.swift
//  SwiftUI_HttpRequest
//
//  Created by Guillaume on 14/07/2023.
//

import SwiftUI

class Network: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published var isSearching: Bool = false
    
    @Published var error: NetworkErrors?
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var errorTitle: String = ""
    
    private var url: String = ""
    
    static var shared = Network()
    private init() {}
    
    private var task:URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session:URLSession) {
        self.session = session
    }
    
    func gettingUrl(search: String?) {
        createUrl(search: search) { result in
            switch result {
                case .success(let urlString):
                    self.url = urlString
                case .failure(let error):
                    self.error = error
                    self.launchingErrorMessage(error: error)
            }
        }
    }
    
    private func createUrl(search: String?, completionHandler: @escaping (Result<String, NetworkErrors>) -> Void ) {
        guard let search = search else {
            completionHandler(.failure(.isNil))
            return
        }
        if search == "" {
            completionHandler(.failure(.empty))
            return
        }
        // Il faut s'assurer que tous les caractères classiques soient acceptés (Taïwan ne passe pas par exemple).
        guard let httpString = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completionHandler(.failure(.strangeCaracters))
            return
        }
        let url = ApiData.url1 + httpString + ApiData.url2 + ApiData.apiKey
        print(url)
        completionHandler(.success(url))
    }
    
    @MainActor
    func searchNews() async {
        isSearching = true
        do {
            articles = try await getNews()
        } catch {
            self.error = error as? NetworkErrors
            launchingErrorMessage(error: error as! NetworkErrors)
        }
        isSearching = false
    }
    
    private func getNews() async throws -> [Article] {
        guard let url = URL(string: url) else {
            throw NetworkErrors.invalidURL
        }
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkErrors.invalidStatusCode
        }
        
        guard let decodedNews = try? JSONDecoder().decode(NewsGot.self, from: data) else {
            throw NetworkErrors.decodingError
        }
        
        return decodedNews.articles
    }
    
    private func launchingErrorMessage(error: NetworkErrors) {
        if let message = error.errorDescription {
            errorMessage = message
        }
        if let title = error.failureReason {
            errorTitle = title
        }
        isError = true
    }
}
