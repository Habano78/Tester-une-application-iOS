//
//  DIContainer.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//

import Foundation
import SwiftUI

class DIContainer: ObservableObject {
        
        let service: DataServiceProtocol
        
        init(service: DataServiceProtocol = DataService()) {
                self.service = service
        }
}



