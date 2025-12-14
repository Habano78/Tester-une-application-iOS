//
//  ListClientViewModel.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//

import SwiftUI
import Combine

class ListClientViewModel: ObservableObject {
        
        enum State {
                case idle
                case loading
                case loaded([Client])
                case empty
                case error(String)
        }
        
        @Published var state: State = .idle
        @Published var isShowingAddClient: Bool = false
        
        private let service: any DataServiceProtocol
        private var cancellables = Set<AnyCancellable>()
        
        init(service: any DataServiceProtocol) {
                self.service = service
                self.bindService()
        }
        
        private func bindService() {
                
                if let dataService = service as? DataService {

                    dataService.$clients
                        .receive(on: RunLoop.main)
                        .sink { [weak self] clients in
                            self?.state = .loaded(clients)
                        }
                        .store(in: &cancellables)
                } else {
                    
                    Task { await loadClients() }
                }
            }
        
        @MainActor
        func loadClients() async {
                if service.clients.isEmpty {
                        self.state = .loading
                }
        }
        
        func openAddClient() {
                isShowingAddClient = true
        }
}
