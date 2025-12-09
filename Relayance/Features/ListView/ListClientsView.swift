//
//  ListClientsView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct ListClientsView: View {
        
        @EnvironmentObject private var container: DIContainer
        @StateObject private var viewModel: ListClientViewModel
        
        init(viewModel: ListClientViewModel) {
                _viewModel = StateObject(wrappedValue: viewModel)
        }
        
        var body: some View {
                NavigationStack {
                        
                        ListContentView(viewModel: viewModel)
                                .navigationTitle("Liste des clients")
                                .toolbar {
                                        Button {
                                                viewModel.openAddClient()
                                        } label: {
                                                Image(systemName: "plus")
                                        }
                                }
                                .sheet(isPresented: $viewModel.isShowingAddClient) {
                                        AjoutClientView()
                                }
                                .task {
                                        await viewModel.loadClients()
                                }
                                .onChange(of: viewModel.isShowingAddClient) { _, estOuvert in
                                        if !estOuvert { viewModel.refresh() }
                                }
                }
        }
}

// MARK: - Preview
#Preview {
        let container = DIContainer()
        
        ListClientsView(viewModel: ListClientViewModel(service: container.service))
                .environmentObject(container)
}
