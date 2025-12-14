//
//  DetailViewModelTests.swift
//  RelayanceTests
//
//  Created by Perez William on 14/12/2025.
//
@testable import Relayance
import Testing
import Foundation


@MainActor
struct DetailViewModelTests {
        
        //MARK: share properties
        let mockService: MockDataService
        let viewModel: DetailClientViewModel
        let client: Client
        
        //MARK: init
        init()
        {
                self.mockService = MockDataService()
                self.client = Client(nom: "test", email: "test@test.com", dateCreation: Date())
                self.viewModel = DetailClientViewModel(client: client, service: mockService)
        }
        
        @Test
        func testSuppressionAppelleService() {
                //WHEN
                viewModel.supprimer()
                
                //THEN
                #expect(mockService.aAppeleSupprimer == true)
                
        }
        
}
