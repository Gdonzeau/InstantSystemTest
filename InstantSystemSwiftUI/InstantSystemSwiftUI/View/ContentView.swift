//
//  ContentView.swift
//  InstantSystemSwiftUI
//
//  Created by Guillaume on 16/07/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network
    
    @State private var search = ""
    
    var body: some View {
        VStack {
            NavigationView {
                ZStack {
                    AppColors.contentViewBackgroundColor.ignoresSafeArea()
                    ScrollView {
                        VStack {
                            ForEach(network.articles, id: \.self) { article in
                                Card(article: article)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                    .navigationTitle("Recherche d'articles")
                }
            }
            .searchable(text: $search, prompt: "Entrez vos mots clés")
            .onSubmit(of: .search) {
                network.gettingUrl(search: search)
                Task {
                    await network.searchNews()
                }
            }
            .alert(network.errorTitle, isPresented: $network.isError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(network.errorMessage)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network(session: URLSession(configuration: .default)))
    }
}
