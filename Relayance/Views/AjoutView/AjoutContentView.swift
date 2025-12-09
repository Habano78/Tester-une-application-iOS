//
//  AjoutContentView.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//

import SwiftUI

struct AjoutContentView: View {
        @StateObject private var viewModel: AjoutClientViewModel
        @Environment(\.dismiss) private var dismiss
        
        // Init Pro
        init(viewModel: AjoutClientViewModel) {
                _viewModel = StateObject(wrappedValue: viewModel)
        }
        
        var body: some View {
                VStack {
                        Text("Ajouter un nouveau client")
                                .font(.largeTitle)
                                .bold()
                                .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        // Les champs sont liés au ViewModel
                        TextField("Nom", text: $viewModel.nom)
                                .font(.title2)
                                .textFieldStyle(.roundedBorder)
                        
                        TextField("Email", text: $viewModel.email)
                                .font(.title2)
                                .textFieldStyle(.roundedBorder)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                        
                        // Le Bouton
                        Button("Ajouter") {
                                save()
                        }
                        .padding(.horizontal, 50)
                        .padding(.vertical)
                        .font(.title2)
                        .bold()
                        .background(RoundedRectangle(cornerRadius: 10).fill(.orange))
                        .foregroundStyle(.white)
                        .padding(.top, 50)
                        // Optionnel : On désactive le bouton si les champs sont vides
                        .disabled(!viewModel.isFormValid)
                        .opacity(viewModel.isFormValid ? 1.0 : 0.5)
                        
                        Spacer()
                }
                .padding()
        }
        
        // Petite fonction privée pour gérer l'appel
        private func save() {
                do {
                        try viewModel.ajouterClient()
                        dismiss() // On ferme seulement si pas d'erreur
                } catch {
                        print("Erreur : \(error)")
                        // Ici, tu pourrais ajouter un @State pour afficher une alerte à l'utilisateur
                }
        }
}

#Preview {
        AjoutClientView()
                .environmentObject(DIContainer())
}
