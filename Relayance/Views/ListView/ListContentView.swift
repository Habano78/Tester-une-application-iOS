//
//  ListClientsViewsr.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//

import SwiftUI

struct ListContentView: View {
    
    @ObservedObject var viewModel: ListClientViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
            
        case .loading:
            ProgressView("Chargement des clients...")
            
        case .error(let message):
            ContentUnavailableView {
                Label("Erreur", systemImage: "exclamationmark.triangle")
            } description: {
                Text(message)
            } actions: {
                Button("Réessayer") {
                    Task { await viewModel.loadClients() }
                }
            }

        case .loaded(let clients):
            if clients.isEmpty {
                ContentUnavailableView("Aucun client", systemImage: "person.slash", description: Text("Appuyez sur + pour ajouter un client."))
            } else {
                List(clients) { client in
                    NavigationLink {
                        DetailClientView(client: client)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(client.nom).font(.headline)
                            Text(client.email).font(.caption).foregroundStyle(.gray)
                        }
                    }
                }
            }
        }
    }
}
