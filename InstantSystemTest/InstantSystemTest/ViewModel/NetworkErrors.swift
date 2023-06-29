//
//  NetworkErrors.swift
//  InstantSystemTest
//
//  Created by Guillaume on 29/06/2023.
//

import Foundation

enum NetworkErrors: String, LocalizedError {
    case noData = "There are no data"
    case noError = "There is no error." // For tests
    case decodingError = "Error while decoding"
    case invalidURL = "Not the right adress."
    case invalidStatusCode = "Invalid Status."
    case errorGenerated = "Error appeared"
    
    var errorDescription: String? {
        switch self {
            case .noData:
                return "Aucune donnée n'est renvoyée."
            case .noError:
                return "Tout va bien, pas d'erreur."
            case .decodingError:
                return "Le fichier renvoyé est endommagé."
            case .invalidURL:
                return "L'adresse internet est non conforme."
            case .invalidStatusCode:
                return "Le statut est invalide."
            case .errorGenerated:
                return "Erreur au moment de la requête réseau."
        }
    }
    var failureReason: String? {
        switch self {
            case .noData: return "Pas de données"
            case .noError:
                return "Pas d'erreur"
            case .decodingError:
                return "Erreur au décodage"
            case .invalidURL:
                return "Mauvaise adresse"
            case .invalidStatusCode:
                return "Statut invalide"
            case .errorGenerated:
                return "Erreur requête réseau"
        }
    }
    
}
