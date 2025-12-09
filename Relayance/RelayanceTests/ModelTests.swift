//
//  ModelTests.swift
//  RelayanceTests
//
//  Created by Perez William on 04/12/2025.
//
import Foundation
import Testing
@testable import Relayance

struct ModelTests {
        
        //MARK: Vérifier que la méthode identifie si client a été créé aujourd'hui
        
        @Test func testNouveauClient() {
                
                //GIVEN
                let client: Client = Client.creerNouveauClient(nom: "harry", email: "harry@test.gmail")
                
                //WHEN
                let isNewInList = client.estNouveauClient()
                
                //THEN
                #expect(isNewInList == true)
        }
        
        @Test func testAncienClient() {
                
                //GIVEN
                let client: Client = Client(nom: "Hermione", email: "Hermione@test.com", dateCreationString: "2013-11-10")
                
                //WHEN
                let isNewInList = client.estNouveauClient()
                
                //THEN
                #expect(isNewInList == false)
                
        }
        
        //MARK: Vérifier qu'on détecte un client déjà présent
        
        @Test func testClientExists() {
                
                //GIVEN
                let frida = Client.creerNouveauClient(nom: "Frida", email: "frida@example.com")
                let yan = Client.creerNouveauClient(nom: "yan", email: "yan@yahoo.com")
                let listToCheck = [frida, yan]
                
                //WHEN
                let isFridaInList = frida.clientExiste(clientsList: listToCheck)
                let isYanInList = yan.clientExiste(clientsList: listToCheck)
                
                //THEN
                #expect(isFridaInList == true)
                #expect(isYanInList == true)
                
        }
        
        @Test func testClientDoesNotExist() {
                
                //GIVEN
                let berta: Client = Client(nom: "Berta", email: "berta@example.com", dateCreationString: "2020-01-01T10:00:00Z")
                let frida = Client.creerNouveauClient(nom: "Frida", email: "frida@example.com")
                let yan = Client.creerNouveauClient(nom: "yan", email: "yan@yahoo.com")
                
                let listToCheck = [frida, yan]
                
                //WHEN
                let didClientExists =  berta.clientExiste(clientsList: listToCheck)
                
                //THEN
                #expect(didClientExists == false)
        }
        
        //MARK: Teste si la func affiche la date au bon format
        
        @Test func testFormatDateVersString(){
                
                //GIVEN
                let client = Client(nom: "Berta", email: "berta@example.com", dateCreationString: "2020-01-01T10:00:00Z")
                
                //WHEN
                let formattedDate =  client.formatDateVersString()
                
                //THEN
                #expect(formattedDate == "01-01-2020")
        }
        
        @Test func testDateCreationInvalide() {
                // GIVEN
                let client = Client(nom: "Test", email: "t@t.fr", dateCreationString: "DATE_INVALIDE")
                let maintenant = Date()
                
                // WHEN
                let dateObtenue = client.dateCreation
                
                // THEN
                let difference = abs(dateObtenue.timeIntervalSince(maintenant))
                
                // On vérifie que la différence est inférieure à 1 seconde
                #expect(difference < 1)
        }
}

