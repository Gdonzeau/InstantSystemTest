//
//  SearchViewControllerTextFieldDelegate.swift
//  InstantSystemTest
//
//  Created by Guillaume on 29/06/2023.
//

import Foundation
import UIKit

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
