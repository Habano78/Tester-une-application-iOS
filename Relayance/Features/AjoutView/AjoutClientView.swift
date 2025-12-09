//
//  AjoutClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct AjoutClientView: View {
        
        @EnvironmentObject private var container: DIContainer
        
        var body: some View {
                
                let viewModel = AjoutClientViewModel(service: container.service)
                
                AjoutClientContentView(viewModel: viewModel)
        }
}
