//
//  File.swift
//  RastroPacote
//
//  Created by Anthony José on 18/01/23.
//

import Foundation

// Implement correio API here.

class Correios {
    func getObject(_ code: String, completion: @escaping (Result<[PackageElement], PackError>) -> ()) async {
        URLSession.shared.dataTask(with: URL(string: "https://correios-api-low.vercel.app/api/hello?code=\(code)")!) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            Task {
                do {
                    guard let package: [PackageElement] = try? JSONDecoder().decode([PackageElement].self, from: data) else {
                        completion(.failure(.badPack))
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(package))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.badPack))
                    }
                }
            }
        }.resume()
    }
}


// MARK: - PackageElement
struct PackageElement: Codable {
    let codObjeto: String
    let eventos: [Evento]
    let modalidade: String
    let tipoPostal: TipoPostal
    let habilitaAutoDeclaracao, permiteEncargoImportacao, habilitaPercorridaCarteiro, bloqueioObjeto: Bool
    let possuiLocker, habilitaLocker, habilitaCrowdshipping: Bool
}

// MARK: - Evento
struct Evento: Codable {
    let codigo, descricao, dtHrCriado, tipo: String
    let unidade: Unidade
    let urlIcone: String
}

// MARK: - Unidade
struct Unidade: Codable {
    let endereco: Endereco
    let tipo: String
}

// MARK: - Endereco
struct Endereco: Codable {
    let cidade, uf: String
    let bairro, cep, logradouro, numero: String?
}

// MARK: - TipoPostal
struct TipoPostal: Codable {
    let categoria, descricao, sigla: String
}


// MARK: - ErrorPackageElement
struct ErrorPackageElement: Codable {
    let codObjeto, mensagem: String
    let habilitaAutoDeclaracao, permiteEncargoImportacao, habilitaPercorridaCarteiro, bloqueioObjeto: Bool
    let possuiLocker, habilitaLocker: Bool
}


enum PackError: Error {
    case badPack
}
