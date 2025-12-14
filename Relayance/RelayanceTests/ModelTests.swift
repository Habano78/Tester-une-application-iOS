//
//  ModelTests.swift
//  RelayanceTests
//
//  Refactored for Strong Typing
//

import Foundation
import Testing
@testable import Relayance

struct ModelTests {
        
        // MARK: verifier Nouveau Client
        
        @Test func testNouveauClient() {
                // GIVEN
                let client = Client(nom: "Harry", email: "harry@test.gmail", dateCreation: Date())
                
                // WHEN
                let isNew = client.estNouveauClient
                
                // THEN
                #expect(isNew == true)
        }
        
        @Test func testAncienClient() {
                // GIVEN
                let datePassee = Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date() /// passé
                
                let client = Client(nom: "Hermione", email: "hermione@test.com", dateCreation: datePassee)
                
                // WHEN
                let isNew = client.estNouveauClient
                
                // THEN
                #expect(isNew == false)
        }
        
        // MARK: - Test Égalité & Existence
        // On teste donc si Swift reconnait bien que deux clients avec le même ID sont identiques.
        
        @Test func testClientEqualityAndExistence() {
                // GIVEN
                let idCommun = UUID()
                let dateCommune = Date.now
                
                let fridaV1 = Client(id: idCommun, nom: "Frida", email: "frida@example.com", dateCreation: dateCommune)
                let fridaV2 = Client(id: idCommun, nom: "Frida", email: "frida@example.com", dateCreation: dateCommune)
                
                let yan = Client(nom: "Yan", email: "yan@yahoo.com")
                
                let listToCheck = [fridaV1, fridaV2]
                
                // WHEN & THEN
                #expect(fridaV1 == fridaV2)
                #expect(fridaV1 != yan)
                
                #expect(listToCheck.contains(fridaV2) == true)
                #expect(listToCheck.contains(yan) == false)
        }
        
        // MARK: - Test Formatage Date
        
        @Test func testFormatDateVersString() {
                // GIVEN
                // On construit une date fixe pour que le test soit déterministe (toujours pareil)
                var components = DateComponents()
                components.year = 2020
                components.month = 1
                components.day = 1
                components.hour = 12
                
                let fixedDate = Calendar.current.date(from: components)!
                let client = Client(nom: "Berta", email: "berta@example.com", dateCreation: fixedDate)
                
                // WHEN
                let formattedDate = client.formatDateVersString()
                
                // THEN
                #expect(formattedDate.contains("2020"))
        }
        
        // MARK: - Test Validité Email
        
        @Test func testEmailValidation() {
                // GIVEN
                let clientValide = Client(nom: "Ok", email: "test@test.com")
                let clientInvalide = Client(nom: "Ko", email: "test-pas-d-arobase.com")
                
                // THEN
                #expect(clientValide.emailEstValide == true)
                #expect(clientInvalide.emailEstValide == false)
        }
}
