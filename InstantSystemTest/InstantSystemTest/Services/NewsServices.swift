//
//  NewsServices.swift
//  InstantSystemTest
//
//  Created by Guillaume on 29/06/2023.
//

import Foundation

class NewsServices {
    static var shared = NewsServices()
    private init() {}
    
    private var task:URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session:URLSession) {
        self.session = session
    }
    
    func getNews(stringAdress: String, completionHandler: @escaping (Result<NewsGot,NetworkErrors>)->Void) {
        guard let url = URL(string: stringAdress) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completionHandler(.failure(.errorGenerated))
                    return
                }
                guard let dataUnwrapped = data else {
                    completionHandler(.failure(.noData))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(.failure(.invalidStatusCode))
                    return
                }
                do {
                    let newsReceived = try JSONDecoder().decode(NewsGot.self, from: dataUnwrapped)
                    completionHandler(.success(newsReceived))
                } catch {
                    completionHandler(.failure(.decodingError))
                }
            }
        }
        task?.resume()
    }
}
