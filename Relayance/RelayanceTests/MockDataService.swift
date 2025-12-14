//
//  Mock.swift
//  RelayanceTests
//
//  Created by Perez William on 13/12/2025.
//

import Foundation
@testable import Relayance

class MockDataService: DataServiceProtocol {
        
        //MARK: Properties
        @Published var clients: [Client] = []
        
        var aAppeleAjouter = false
        var aAppeleSupprimer = false
        var erreurAEnvoyer: Error? = nil
        
        //MARK: methodes
        func ajouter(client: Client) throws {
                
                if let erreur = erreurAEnvoyer {
                        throw erreur
                }
                aAppeleAjouter = true
                clients.append(client)
        }
        
        func supprimer(client: Client) {
                aAppeleSupprimer = true
                clients.removeAll { $0.id == client.id }
        }
}
