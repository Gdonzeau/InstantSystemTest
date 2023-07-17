//
//  InstantSystemSwiftUIApp.swift
//  InstantSystemSwiftUI
//
//  Created by Guillaume on 16/07/2023.
//

import SwiftUI

@main
struct InstantSystemSwiftUIApp: App {
    var body: some Scene {
        let network = Network.shared
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
