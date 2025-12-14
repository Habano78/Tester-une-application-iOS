//
//  ClientRowView.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//

import SwiftUI

struct ClientRowView: View, Equatable {
        
        let client: Client
        
        static func == (lhs: ClientRowView, rhs: ClientRowView) -> Bool {
                return lhs.client == rhs.client
        }
        
        var body: some View {
                VStack(alignment: .leading) {
                        Text(client.nom)
                                .font(.headline)
                        Text(client.email)
                                .font(.caption)
                                .foregroundStyle(.gray)
                }
                .padding(.vertical, 4)
        }
}
