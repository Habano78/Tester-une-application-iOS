//
//  ModelDataTests.swift
//  RelayanceTests
//
//  Created by Perez William on 06/12/2025.
//

import Testing
@testable import Relayance
import Foundation

struct ModelDataTests {
        
        @Test func testChargementDonnesSucced() {
                
                //GIVEN
                let model = DataService()
                
                //WHEN
                /// Chargement automatique
                
                //THEN
                #expect(model.clients.isEmpty == false)
                #expect(model.clients.first?.nom != nil)
        }
        
        
        //MARK: verifier l'ajout d'un nouveau client
        @Test func testAjoutClientSucced() async throws {
                // GIVEN
                let model = DataService()
                let nombreInitial = model.clients.count
                let newClient = Client(nom: "Berta", email: "b@b.com", dateCreation: Date())
                
                //WHEN
                try await model.ajouter(client: newClient)
                
                // THEN
                #expect(model.clients.count == nombreInitial + 1)
                #expect(model.clients.first?.nom == "Berta")
        }
        
        
        @MainActor
        @Test func testAjoutClientFailedMailInvalid() {
                
                // GIVEN
                let model = DataService()
                let newClient = Client(nom: "Berta", email: "berta_invalide", dateCreation: Date())
                var erreurCapturee: ClientError? = nil
                
                // WHEN
                do {
                        try model.ajouter(client: newClient)
                } catch {
                        
                        erreurCapturee = error as? ClientError
                }
                
                // THEN
                #expect(erreurCapturee == ClientError.emailInvalide)
        }
        
        //MARK: verifier la suppression d'un client dans la liste
        @MainActor
        @Test func testSupprimerClientSucced()  {
                //GIVEN
                let model = DataService()
                let clientToDelete = Client(nom: "Berta", email: "berta@example.com", dateCreation: Date())
                model.clients.append(clientToDelete)
                let nombreDeClientsInitiaux = model.clients.count
                
                //WHEN
                model.supprimer(client: clientToDelete)
                
                //THEN
                #expect(model.clients.count == nombreDeClientsInitiaux - 1)
                let estPresent = model.clients.contains(where: { $0.id == clientToDelete.id })
                #expect(!estPresent)
                
                
        }
}
