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
    let author: String?
    let title: String
    let description: String
}
