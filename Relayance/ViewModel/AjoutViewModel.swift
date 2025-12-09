//
//  AjoutViewModel.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//

import Foundation

class AjoutClientViewModel: ObservableObject {
        
        //MARK: form properties
        @Published var nom: String = ""
        @Published var email: String = ""
        
        //MARK: dependencies
        private let service: DataServiceProtocol
        
        //MARK: init
        init(service: DataServiceProtocol){
                self.service = service
        }
       
        // MARK: methods
            
            // Retourne vrai si le formulaire est valide (pour activer/désactiver le bouton par exemple)
            var isFormValid: Bool {
                return !nom.isEmpty && !email.isEmpty
            }
            
            func ajouterClient() throws {
                // 1. On crée l'objet temporaire
                // Note: Ici on pourrait gérer la date plus proprement, mais gardons la string pour l'instant
                let nouveauClient = Client(nom: nom, email: email, dateCreationString: "09-12-2025")
                
                // 2. On appelle le service (qui peut renvoyer une erreur si l'email est invalide)
                try service.ajouter(client: nouveauClient)
            }
        
        
        
}
