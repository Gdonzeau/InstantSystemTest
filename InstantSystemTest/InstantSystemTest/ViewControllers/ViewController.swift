//
//  ViewController.swift
//  InstantSystemTest
//
//  Created by Guillaume on 26/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let newsServices = NewsServices.shared
    
    let stringUrl = "https://newsapi.org/v2/everything?q=France&sortBy=popularity&apiKey=10a80a3edbc94a49b406c4f1fe8eaf67"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newsServices.getNews(stringAdress: stringUrl) { result in
            print(result)
        }
         
    }


}

