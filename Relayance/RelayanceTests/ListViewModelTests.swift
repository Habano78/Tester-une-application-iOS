//
//  ListViewModelTests.swift
//  RelayanceTests
//
//  Created by Perez William on 14/12/2025.
//

@testable import Relayance
import Testing
import Foundation


struct ListViewModelTests {
        
        //MARK: share properties
        let mockService: MockDataService
        let viewModel: ListClientViewModel
        
        //MARK: init
        init()
        {
                self.mockService = MockDataService()
                self.viewModel = ListClientViewModel(service: mockService)
        }
        
        @Test
        func testOpenAddClient () {
                
                //GIVEN
                #expect(viewModel.isShowingAddClient == false)
                
                //WHEN
                viewModel.openAddClient()
                
                //THEN
                #expect(viewModel.isShowingAddClient == true)
        }
        
        @Test
        func testLoadClientsMetEnLoadingSiVide() async {
                //GIVEN
                mockService.clients = []
                
                //WHEN
                await viewModel.loadClients()
                
                //THEN
                if case .loading = viewModel.state {
                        #expect(true)
                } else {
                        #expect(Bool(false), "L'état aurait dû passer à .loading car la liste est vide")
                }
        }
}
