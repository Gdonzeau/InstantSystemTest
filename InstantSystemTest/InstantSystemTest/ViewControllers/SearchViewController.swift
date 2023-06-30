//
//  SearchViewController.swift
//  InstantSystemTest
//
//  Created by Guillaume on 26/06/2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchViewModel = SearchViewModel.shared
    let yourAPIKey = APIKey.key
    
    var articles: [Article] = []
    
    var article = Article(author: "", title: "", url: "", description: "", urlToImage: "", publishedAt: "", content: "")
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func requestAPI(_ sender: UIButton) {
        toggleActivityIndicator(shown: true)
        resigningFirstResponder()
        gettingNews()
    }
    @IBAction func tapGestureDetected(_ sender: UITapGestureRecognizer) {
        resigningFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Entrez un thème"
        toggleActivityIndicator(shown: false)
        initializeTableView()
        initializeTextField()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToNews" {
            let newsVC = segue.destination as! NewsViewController
            newsVC.article = article
        }
    }
    
    private func initializeTableView() {
        tapGesture.cancelsTouchesInView = false // Pas vraiment lié à la tableView mais sans cette ligne on ne peut pas en sélectionner les cellules
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cellNews")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func initializeTextField() {
        searchField.delegate = self
    }
    
    // Pour éviter un double appel réseau (même si le premier serait instantanément arrêté par task?.cancel(), je masque le bouton et fais apparaître un activity Indicator le temps de la recherche
    private func toggleActivityIndicator(shown: Bool) {
        searchButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    // Une fonction pour gérer la disparition du clavier
    private func resigningFirstResponder() {
        searchField.resignFirstResponder()
    }
    
    private func createUrl() -> String? {
        let stringUrl1 = "https://newsapi.org/v2/everything?q="
        let stringUrl2 = "&sortBy=popularity&apiKey="
        
        guard let search = searchField.text else {
            allErrors(errorMessage: "Aucune entrée détectée", errorTitle: "Nil")
            return nil
        }
        
        if search == "" {
            allErrors(errorMessage: "Vous devez entrer quelque chose", errorTitle: "Pas de données")
            return nil
        }
        
        // Il faut s'assurer que tous les caractères classiques soient acceptés (Taïwan ne passe pas par exemple).
        guard let httpString = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            allErrors(errorMessage: "Vous devez utiliser des caratères conformes", errorTitle: "Erreur de caratères")
            return nil
        }
        return stringUrl1 + httpString + stringUrl2
    }
    
    private func gettingNews() {
        
        guard let url = createUrl() else {
            return
        }
        
        let finalUrl = url + yourAPIKey
        
        searchViewModel.getNews(stringAdress: finalUrl) { result in
            switch result {
                case.success( _):
                    self.tableView.reloadData()
                case.failure(let error):
                    if let errorMessage = error.errorDescription,
                       let errorTitle = error.failureReason {
                        self.allErrors(errorMessage: errorMessage, errorTitle: errorTitle)
                    }
            }
        }
        self.toggleActivityIndicator(shown: false)
    }
    
    func allErrors(errorMessage: String, errorTitle: String) {
        let alertVC = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
        
        toggleActivityIndicator(shown: false)
    }
}

