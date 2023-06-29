//
//  ViewController.swift
//  InstantSystemTest
//
//  Created by Guillaume on 26/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let newsServices = NewsServices.shared
    let yourAPIKey = APIKey.key
    
    let stringUrl = "https://newsapi.org/v2/everything?q=France&sortBy=popularity&apiKey="

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = stringUrl + yourAPIKey
        newsServices.getNews(stringAdress: url) { result in
            print(result)
        }
         
    }
    
    


}

