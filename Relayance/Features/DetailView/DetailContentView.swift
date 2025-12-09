//
//  DetailContentView.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//


import SwiftUI

struct DetailClientContentView: View {
        
        //MARK: dependencies
        @StateObject private var viewModel: DetailClientViewModel
        //MARK: in properties
        @Environment(\.dismiss) private var dismiss
        
        //MARK: init
        init(viewModel: DetailClientViewModel) {
                _viewModel = StateObject(wrappedValue: viewModel)
        }
        
        //MARK: View
        var body: some View {
                VStack(spacing: 20) {
                        
                        //
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
                        
                        //
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
