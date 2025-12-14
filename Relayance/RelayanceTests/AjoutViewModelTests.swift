//
//  AjoutViewModelTests.swift
//  RelayanceTests
//
//  Created by Perez William on 14/12/2025.
//

import Testing
@testable import Relayance

@MainActor
struct AjoutViewModelTests {
        
        //MARK: share properties
        let mockService: MockDataService
        let viewModel: AjoutClientViewModel
        
        //MARK: init
        init()
        {
                self.mockService = MockDataService()
                self.viewModel = AjoutClientViewModel(service: mockService)
        }

        //MARK: tests
        
        @Test
        func testFormulaireInvalideCarChampsVides () {
                
                //THEN
                #expect(!viewModel.isFormValid)
                #expect(viewModel.nom.isEmpty)
        }
        
        @Test
        func testFormulaireValideCarChampsPlein () {
                //WHEN
                viewModel.nom = "Ana"
                viewModel.email = "ana@gmail.com"
                
                //THEN
                #expect(viewModel.isFormValid)
        }
        
        @Test
        func testAjoutClientSucces() {
                // GIVEN
                viewModel.nom = "Succes"
                viewModel.email = "succes@test.com"
                
                // WHEN
                let resultat = viewModel.ajouterClient()
                
                // THEN
                #expect(resultat == true)
                #expect(mockService.aAppeleAjouter == true)
                #expect(viewModel.showAlert == false)
        }
        
        @Test
        func testAjoutClientEchecEmailInvalide () {
                //GIVEN
                mockService.erreurAEnvoyer = ClientError.emailInvalide
                viewModel.nom = "Echec"
                viewModel.email = "echectest"
                
                //WHEN
                let resulatt = viewModel.ajouterClient()
                
                //THEN
                #expect(resulatt == false)
                #expect(viewModel.showAlert == true)
                #expect(viewModel.errorMessage == "Email invalide.")
        }
        
        @Test func testAjoutClientEchecClientExiste() {
                
                //GIVEN
                mockService.erreurAEnvoyer = ClientError.clientExiste
                viewModel.nom = "Echec"
                viewModel.email = "echectest@test.com"
                
                //WHEN
                let resulatt = viewModel.ajouterClient()
                
                //THEN
                #expect(resulatt == false)
                #expect(viewModel.showAlert == true)
                #expect(viewModel.errorMessage ==  "Ce client existe déjà.")
        }
        
        @Test
        func testAjoutClientEchecErreurInconnue() {
                //GIVEN
                struct ErreurReseau: Error{}
                mockService.erreurAEnvoyer = ErreurReseau()
                
                viewModel.nom = "Echec"
                viewModel.email = "echectest@test.com"
                
                //WHEN
                let resultat = viewModel.ajouterClient()
                
                //THEN
                #expect(resultat == false)
                #expect(viewModel.showAlert == true)
                #expect(viewModel.errorMessage == "Erreur inconnue.")
        }
}
