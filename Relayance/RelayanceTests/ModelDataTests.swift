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
                let fichierJson = "Source.json"
                
                //WHEN
                let list : [Client] = ModelData.chargement(fichierJson)
                
                //THEN
                #expect(list.isEmpty == false)
                #expect(list.first?.nom == "Frida Kahlo")
        }
        
        
        //MARK: verifier l'ajout d'un nouveau client
        @Test func testAjoutClientSucced() throws {
                
                //GIVEN
                let model = ModelData()  /// on instancie le gestionnaire de data
                let nombreInitial = model.clients.count /// on compte le nombre inital de clients dans la liste
                let newClient = Client(nom: "Berta", email: "berta@example.com", dateCreationString: "2020-01-01") /// on crée un nouveau client
                
                //WHEN
                try model.ajouter(client: newClient)
                
                // THEN
                #expect(model.clients.count == nombreInitial + 1)
                #expect(model.clients.last?.nom == "Berta")
        }
        
        
        @Test func testAjoutClientFailedMailInvalid() {
                
                // GIVEN
                let model = ModelData()
                let newClient = Client(nom: "Berta", email: "berta_invalide", dateCreationString: "2020-01-01")
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
        @Test func testSupprimerClientSucced()  {
                //GIVEN
                let model = ModelData()
                let clientToDelete = Client(nom: "Berta", email: "berta@example.com", dateCreationString: "2020-01-01")
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
