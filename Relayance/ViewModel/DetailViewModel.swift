//
//  DetailViewModel.swift.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//

import Foundation
import SwiftUI

class DetailClientViewModel : ObservableObject {
        
//MARK: properties
        let client : Client
        
        //MARK: dependencies
        private let service : DataServiceProtocol
        
        //MARK: init
        init(client: Client, service: DataServiceProtocol){
                self.client = client
                self.service = service
        }
        
        //MARK: methods
        func supprimer(){
                service.supprimer(client: client)
        }
}
