//
//  AjoutClientContentView.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//

import SwiftUI

struct AjoutClientContentView: View {
        
        @StateObject private var viewModel: AjoutClientViewModel
        @Environment(\.dismiss) private var dismiss
        
        init(viewModel: AjoutClientViewModel) {
                _viewModel = StateObject(wrappedValue: viewModel)
        }
        
        var body: some View {
                VStack(spacing: 30) {
                        
                        Text("Nouveau Client")
                                .font(.title)
                                .bold()
                                .padding(.top)
                        
                        // Bloc des Champs
                        VStack(spacing: 20) {
                                
                                /// Nom
                                VStack(alignment: .leading, spacing: 8) {
                                        Text("NOM COMPLET")
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.secondary)
                                        
                                        HStack {
                                                Image(systemName: "person.fill")
                                                        .foregroundStyle(.gray)
                                                TextField("Ex: Jean Dupont", text: $viewModel.nom)
                                                        .autocorrectionDisabled()
                                        }
                                        .padding()
                                        .background(Color(UIColor.systemGray6))
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                
                                ///  Email
                                VStack(alignment: .leading, spacing: 8) {
                                        Text("ADRESSE EMAIL")
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.secondary)
                                        
                                        HStack {
                                                Image(systemName: "envelope.fill")
                                                        .foregroundStyle(.gray)
                                                TextField("Ex: jean@entreprise.com", text: $viewModel.email)
                                                        .textInputAutocapitalization(.never)
                                                        .keyboardType(.emailAddress)
                                                        .autocorrectionDisabled()
                                        }
                                        .padding()
                                        .background(Color(UIColor.systemGray6))
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        //  Bouton Ajouter
                        Button {
                                if viewModel.ajouterClient() {
                                        dismiss()
                                }
                        } label: {
                                HStack {
                                        Text("Ajouter le client")
                                        Image(systemName: "arrow.right.circle.fill")
                                }
                                .font(.headline)
                                .frame(maxWidth: .infinity) 
                                .padding()
                                .background(viewModel.isFormValid ? Color.blue : Color.gray.opacity(0.3))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .animation(.easeInOut, value: viewModel.isFormValid) 
                        }
                        .disabled(!viewModel.isFormValid)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                .alert("Erreur", isPresented: $viewModel.showAlert) {
                        Button("OK", role: .cancel) { }
                } message: {
                        Text(viewModel.errorMessage)
                }
        }
}
