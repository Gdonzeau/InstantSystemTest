//
//  NewsViewController.swift
//  InstantSystemTest
//
//  Created by Guillaume on 30/06/2023.
//

import SafariServices
import UIKit

class NewsViewController: UIViewController {
    
   var article = Article(author: "", title: "", url: "", description: "", urlToImage: "", publishedAt: "", content: "")
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textDescription: UITextView!
    
    @IBAction func accessToArticle(_ sender: UIButton) {
        accessToNewsOnInternet()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    private func updateData() {
        titleLabel.text = article.title
        authorLabel.text = article.author
        dateLabel.text = article.publishedAt
        
        // Formatage de la date - (un prefix(10) aurait pu faire l'affaire, mais nous ne sommes pas à l'abri d'un format différent)
        // On convertit le string reçu au format Date puis on reconvertit ce Date en String au format souhaité.
        dateLabel.text = "Date inconnue" // Si pour une raison ou une autre (mauvais format ou absence de date) il n'y a pas de résultat, on met une "date" par défaut.
        if let stringDate = article.publishedAt {
            if let date = dateFromISOString(stringDate) {
                let formatter = DateFormatter()
                formatter.dateFormat = "d MMM y"
                dateLabel.text = formatter.string(from: date)
            }
        }
        
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            imageView.load(url: url)
        } else {
            imageView.isHidden = true
        }
        if let description = article.description {
            textDescription.text = description
        } else {
            textDescription.text = "Pas de description de cet article"
        }
    }
    
    private func accessToNewsOnInternet() {
        if let urlString = article.url, let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .coverVertical
            present(vc, animated: true)
        } else {
            let error = NetworkErrors.invalidURL
            if let errorMessage = error.errorDescription, let errorTitle = error.failureReason {
                allErrors(errorMessage: errorMessage, errorTitle: errorTitle)
            }
        }
    }
    
    private func dateFromISOString(_ isoString: String) -> Date? { // On convertit le String de la date au format Date
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate]
        return isoDateFormatter.date(from: isoString)
    }
    
    func allErrors(errorMessage: String, errorTitle: String) {
        let alertVC = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
