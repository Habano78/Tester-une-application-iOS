//
//  AjoutViewModel.swift
//  Relayance
//
//  Created by Perez William on 09/12/2025.
//

import Foundation

class AjoutClientViewModel: ObservableObject {
        
        //MARK: properties
        private let service: any DataServiceProtocol
        
        @Published var nom: String = ""
        @Published var email: String = ""
        @Published var showAlert: Bool = false
        @Published var errorMessage: String = ""
        
        var isFormValid: Bool {
            /// vérifie que les champs ne sont pas vides
            guard !nom.isEmpty, !email.isEmpty else { return false }
            
            /// vérifie le format de l'email (Regex moderne iOS 16+)
            let emailRegex = /[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}/
            let isEmailFormatValid = (try? emailRegex.wholeMatch(in: email)) != nil
            
            return isEmailFormatValid
        }
        
        //MARK: init
        init(service: any DataServiceProtocol) {
                self.service = service
        }
        
        //MARK: methodes
        func ajouterClient() -> Bool {
        
                let nouveauClient = Client(nom: nom, email: email, dateCreation: Date())
                
                do {
                        try service.ajouter(client: nouveauClient)
                        return true
                } catch let error as ClientError {
                        self.showAlert = true
                        switch error {
                        case .emailInvalide:
                                self.errorMessage = "Email invalide."
                        case .clientExiste:
                                self.errorMessage = "Ce client existe déjà."
                        }
                        return false
                } catch {
                        self.showAlert = true
                        self.errorMessage = "Erreur inconnue."
                        return false
                }
        }
}
