//
//  Model.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

struct Client: Codable, Hashable, Identifiable {
        var id =  UUID ()
        var nom: String
        var email: String
        private var dateCreationString: String
        var dateCreation: Date {
                Date.dateFromString(dateCreationString) ?? Date.now
        }
        
        enum CodingKeys: String, CodingKey {
                case nom
                case email
                case dateCreationString = "date_creation"
        }
        
        /// Constructeur
        init(nom: String, email: String, dateCreationString: String) {
                self.nom = nom
                self.email = email
                self.dateCreationString = dateCreationString
        }
        
        /// Fonctions
        static func creerNouveauClient(nom: String, email: String) -> Client {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                
                return Client(nom: nom, email: email, dateCreationString: dateFormatter.string(from: Date.now))
        }
        
        //Est-ce que le client a été créé aujourd'hiui ? True/False
        func estNouveauClient() -> Bool {
                let aujourdhui = Date.now
                let dateCreation = self.dateCreation
                
                if aujourdhui.getYear() != dateCreation.getYear() ||
                        aujourdhui.getMonth() != dateCreation.getMonth() ||
                        aujourdhui.getDay() != dateCreation.getDay() {
                        return false
                }
                return true
        }
        
        
        // Est-ce que le client existe dans la BD ? True/False
        func clientExiste(clientsList: [Client]) -> Bool {
                if clientsList.contains(where: { $0 == self }) {
                        return true
                }
                return false
        }
        
        
        func formatDateVersString() -> String {
                return Date.stringFromDate(self.dateCreation)
        }
        
        var emailEstValide: Bool {
                // cette formule vérifie le format a@b.c
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: self.email)
        }
}
