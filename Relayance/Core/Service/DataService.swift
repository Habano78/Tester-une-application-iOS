//
//  ModelData.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation



//MARK: ServiceProtocol
protocol DataServiceProtocol {
        var clients: [Client] { get set }
        func ajouter(client: Client) throws
        func supprimer(client: Client)
}


//MARK: implementation
class DataService: ObservableObject, DataServiceProtocol {
        
        //MARK: properties
        @Published var clients: [Client] = []
        private let source: String = "Source.json"
        
        //MARK: init
        init() {
                self.clients = DataService.chargement(source)
        }
        
        //MARK: methods
        static func chargement<T: Decodable>(_ nomFichier: String) -> T {
                let data: Data
                
                guard let file = Bundle.main.url(forResource: nomFichier, withExtension: nil)
                else {
                        fatalError("Impossible de trouver \(nomFichier) dans le main bundle.")
                }
                
                do {
                        data = try Data(contentsOf: file)
                } catch {
                        fatalError("Impossible de charger \(nomFichier) depuis le main bundle:\n\(error)")
                }
                
                do {
                        let decoder = JSONDecoder()
                        return try decoder.decode(T.self, from: data)
                } catch {
                        fatalError("Impossible de parser \(nomFichier) en tant que \(T.self):\n\(error)")
                }
        }
        
        //MARK: add
        func ajouter(client: Client) throws {
                guard client.emailEstValide else {
                        throw ClientError.emailInvalide
                }
                guard !client.clientExiste(clientsList: clients) else {
                        throw ClientError.clientExiste
                }
                self.clients.append(client)
            }
        
        //MARK: del
        func supprimer(client: Client) {
                self.clients.removeAll { $0.id == client.id }
        }
        
}
