//
//  ModelData.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

// MARK: - Protocol
protocol DataServiceProtocol: ObservableObject {
        var clients: [Client] { get }
        func ajouter(client: Client) throws
        func supprimer(client: Client)
}

// MARK: - Implementation
class DataService: ObservableObject, @preconcurrency DataServiceProtocol {
        
        @Published var clients: [Client] = []
        private let source: String = "Source"
        
        //MARK: init
        init() {
                chargerDonnees()
        }
        
        private func chargerDonnees() {
                // Vérification du nom du fichier
                guard let url = Bundle.main.url(forResource: source, withExtension: "json") else {
                        print("❌ ERREUR CRITIQUE : Le fichier \(source).json n'est pas trouvé dans le Bundle.")
                        print("👉 Vérifie que 'Target Membership' est coché pour ce fichier.")
                        return
                }
                
                guard let data = try? Data(contentsOf: url) else {
                        print("❌ ERREUR : Impossible de lire les données du fichier.")
                        return
                }
                
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                do {
                        self.clients = try decoder.decode([Client].self, from: data)
                        print("✅ SUCCÈS : \(self.clients.count) clients chargés et affichés.")
                } catch {
                        print("❌ ERREUR DE DÉCODAGE PRÉCISE :")
                        print(error) // Ceci nous dira exactement quelle ligne du JSON bloque
                }
        }
        
        @MainActor
        func ajouter(client: Client) throws {
                guard client.emailEstValide else { throw ClientError.emailInvalide }
                guard !clients.contains(where: { $0.id == client.id || $0.email == client.email }) else
                
                { throw ClientError.clientExiste }
                
                self.clients.insert(client, at: 0)
        }
        
        
        @MainActor
        func supprimer(client: Client) {
                self.clients.removeAll { $0.id == client.id }
        }
}
