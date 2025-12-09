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
        DetailClientContentView(viewModel: DetailClientViewModel(client: client, service: container.service))
    }
}
