//
//  ListClientsView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct ListClientsView: View {
        
        @StateObject private var viewModel: ListClientViewModel
        
        //MARK: init
        init(service: any DataServiceProtocol) {
                _viewModel = StateObject(wrappedValue: ListClientViewModel(service: service))
            }
        
        //MARK: Body
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
                }
        }
}
