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
        
        //Error
        @Published var showAlert: Bool = false
        @Published var errorMessage: String = ""
        
        //MARK: computing
        var isFormValid: Bool {
                return !nom.isEmpty && !email.isEmpty
        }
        
        //MARK: dependencies
        private let service: DataServiceProtocol
        
        //MARK: init
        init(service: DataServiceProtocol){
                self.service = service
        }
        
        // MARK: methods
        func ajouterClient() -> Bool {
                
                let nouveauClient = Client(nom: nom, email: email, dateCreationString: Date.stringFromDate(Date.now))
                
                do {
                       
                        try service.ajouter(client: nouveauClient)
                        return true
                        
                } catch let error as ClientError {
                        
                        switch error {
                        case .emailInvalide:
                                self.errorMessage = "L'adresse email saisie n'est pas valide. Veuillez vérifier le format (exemple@domaine.com)."
                        case .clientExiste:
                                self.errorMessage = "Ce client existe déjà dans la base de données."
                        }
                        
                        self.showAlert = true
                        return false
                        
                } catch {
                        self.errorMessage = "Une erreur inconnue est survenue : \(error.localizedDescription)"
                        self.showAlert = true
                        return false
                }
        }
        
}
