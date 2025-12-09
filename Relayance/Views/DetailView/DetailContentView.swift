//
//  DetailContentView.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//


import SwiftUI

struct DetailClientContentView: View {
        
        @StateObject private var viewModel: DetailClientViewModel
        @Environment(\.dismiss) private var dismiss
        
        // Init "Pro" pour injecter le ViewModel proprement
        init(viewModel: DetailClientViewModel) {
                _viewModel = StateObject(wrappedValue: viewModel)
        }
        
        var body: some View {
                VStack(spacing: 20) {
                        
                        // --- Infos Client ---
                        Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.blue)
                                .padding(.top)
                        
                        Text(viewModel.client.nom)
                                .font(.title)
                                .bold()
                        
                        Text(viewModel.client.email)
                                .font(.title2)
                                .foregroundStyle(.gray)
                        
                        Spacer()
                        
                        // --- Bouton Supprimer ---
                        Button(role: .destructive) {
                                viewModel.supprimer()
                                dismiss()
                                
                        } label: {
                                HStack {
                                        Image(systemName: "trash")
                                        Text("Supprimer le client")
                                }
                                .font(.title3)
                                .bold()
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.red.opacity(0.1))
                                .foregroundStyle(.red)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                        .padding()
                }
                .navigationTitle("Détails")
                .navigationBarTitleDisplayMode(.inline)
        }
}

// MARK: - Preview
#Preview {
        // On crée un ViewModel factice pour la preview
        let mockClient = Client(nom: "Preview", email: "test@test.com", dateCreationString: "2025")
        let mockService = DataService() // Ou un MockService si tu en as un
        let vm = DetailClientViewModel(client: mockClient, service: mockService)
        
        DetailClientContentView(viewModel: vm)
}
