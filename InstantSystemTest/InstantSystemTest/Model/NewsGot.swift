//
//  NewsGot.swift
//  InstantSystemTest
//
//  Created by Guillaume on 29/06/2023.
//

import Foundation

struct NewsGot: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    var author: String?
    var title: String?
    var url: String?
    var description: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
