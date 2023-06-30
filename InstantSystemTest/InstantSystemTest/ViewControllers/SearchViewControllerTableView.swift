//
//  SearchViewControllerTableView.swift
//  InstantSystemTest
//
//  Created by Guillaume on 29/06/2023.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let title = searchViewModel.articles[indexPath.row].title
        cell.cellTitle.text = title
        
        if let imageUrl = searchViewModel.articles[indexPath.row].urlToImage, let urlImage = URL(string: imageUrl) {
            cell.urlImage = urlImage
        } else {
            cell.urlImage = nil
            cell.imageView?.backgroundColor = .gray
        }
        cell.loadImage()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        article.title = searchViewModel.articles[indexPath.row].title
        article.author = searchViewModel.articles[indexPath.row].author
        article.description = searchViewModel.articles[indexPath.row].description
        article.urlToImage = searchViewModel.articles[indexPath.row].urlToImage
        article.content = searchViewModel.articles[indexPath.row].content
        article.url = searchViewModel.articles[indexPath.row].url
        article.publishedAt = searchViewModel.articles[indexPath.row].publishedAt
        
        performSegue(withIdentifier: "segueToNews", sender: self)
    }
}
