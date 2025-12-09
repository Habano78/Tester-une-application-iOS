//
//  ListViewModel.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//

import SwiftUI

class ListClientViewModel: ObservableObject {
        
        // MARK: state of the screen
        enum State {
                case idle
                case loading
                case loaded([Client])
                case error(String)
        }
        
        // MARK: published Properties
        @Published var state: State = .idle
        @Published var isShowingAddClient: Bool = false
        
        // MARK: dependencies
        private let service: DataServiceProtocol
        
        // MARK: init
        init(service: DataServiceProtocol) {
                self.service = service
        }
        
        // MARK: - Methods
        
        /// Charge les données initiales (avec état de chargement)
        @MainActor
        func loadClients() async {
                self.state = .loading
                
                let clients = service.clients
                self.state = .loaded(clients)
        }
        
        /// mise à jour silencieuse
        @MainActor
        func refresh() {
                let clients = service.clients
                self.state = .loaded(clients)
        }
        
        func openAddClient() {
                isShowingAddClient = true
        }
}
