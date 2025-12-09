//
//  AjoutClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

//
//  AjoutClientView.swift
//  Relayance
//
//  C'est le Câbleur : Il prépare le terrain.
//

import SwiftUI

struct AjoutClientView: View {
        
        @EnvironmentObject private var container: DIContainer
        
        var body: some View {
                
                let viewModel = AjoutClientViewModel(service: container.service)
                
                AjoutContentView(viewModel: viewModel)
        }
}

#Preview {
        AjoutClientView()
                .environmentObject(DIContainer())
}
