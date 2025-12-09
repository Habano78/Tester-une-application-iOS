//
//  DetailClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct DetailClientView: View {
    
    let client: Client
    @EnvironmentObject private var container: DIContainer
    
    var body: some View {
        // On initialise le ViewModel avec le client et le service
        // et on le passe à la vue d'affichage
        DetailClientContentView(viewModel: DetailClientViewModel(client: client, service: container.service))
    }
}
