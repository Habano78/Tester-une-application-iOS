//
//  RelayanceApp.swift
//  Relayance
//
//  Created by Amandine Cousin on 08/07/2024.
//

import SwiftUI

@main
struct RelayanceApp: App {
        
    @StateObject private var container = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            ListClientsView(service: container.service)
                .environmentObject(container)
        }
    }
}
