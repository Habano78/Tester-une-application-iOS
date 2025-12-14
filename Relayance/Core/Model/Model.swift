//
//  Model.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//  Refactored for Performance & Safety
//

//
//  Model.swift
//  Relayance
//
//  Refactored for Auto-ID Generation
//

import Foundation

struct Client: Codable, Hashable, Identifiable {
        let id: UUID
        var nom: String
        var email: String
        let dateCreation: Date
        
        enum CodingKeys: String, CodingKey {
                case id
                case nom
                case email
                case dateCreation = "date_creation"
        }
        
        // MARK: - Init Standard (Utilisé quand tu crées un client manuellement dans l'app)
        init(id: UUID = UUID(), nom: String, email: String, dateCreation: Date = Date.now) {
                self.id = id
                self.nom = nom
                self.email = email
                self.dateCreation = dateCreation
        }
        
        // MARK: - Init de Décodage (C'est ICI que ça se joue)
        // Ce constructeur est appelé automatiquement quand on lit le JSON
        init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                // 1. On récupère les champs normaux
                self.nom = try container.decode(String.self, forKey: .nom)
                self.email = try container.decode(String.self, forKey: .email)
                self.dateCreation = try container.decode(Date.self, forKey: .dateCreation)
                
                self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        }
        
        // MARK: - Helpers
        var estNouveauClient: Bool {
                Calendar.current.isDateInToday(dateCreation)
        }
        
        var emailEstValide: Bool {
                // Regex moderne pour valider l'email
                let emailRegex = /[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}/
                return (try? emailRegex.wholeMatch(in: email)) != nil
        }
        
        func formatDateVersString() -> String {
                dateCreation.formatted(date: .numeric, time: .omitted)
        }
}
