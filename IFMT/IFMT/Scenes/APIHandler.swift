//
//  APIHandler.swift
//  IFMT
//
//  Created by Claudio Noberto on 01/04/24.
//

import Foundation
import Alamofire

class APIHandler {
    static let shared = APIHandler()
    
    var userToken: String = ""
    let baseURL = "https://suap.ifmt.edu.br/api/v2/"
    
    func getToken(username: String, password: String, completion: @escaping (Result<String,Error>) -> Void) {
        let endpoint = "autenticacao/token/"
        let finalURL = baseURL + endpoint
        let parameters = ["username": username,"password": password]
        
        AF.request(finalURL, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).response { response in
            switch response.result {
            case .success(let sucess):
                guard let json = try? JSONSerialization.jsonObject(with: sucess!, options: .mutableContainers) as? [String: String] else { return }
                print(json)
                if response.response?.statusCode == 200 {
                    guard let accessToken = json["access"] else { return }
                    self.userToken = accessToken
                    completion(.success(""))
                } else {
                    guard let errorMessage = json["detail"] else { return }
                    completion(.failure(GenericError.genericError(message: errorMessage)))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func getGeneralData(completion: @escaping (Result<GeneralData,Error>) -> Void) {
        let endpoint = "minhas-informacoes/meus-dados/"
        let finalURL = baseURL + endpoint
        let header: HTTPHeaders = [.authorization("Bearer \(userToken)")]
        AF.request(finalURL, method: .get, headers: header).responseDecodable(of: GeneralData.self) { response in
            switch response.result {
            case .success(let sucess):
                completion(.success(sucess))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getBoletimData(completion: @escaping (Result<[BoletimData],Error>) -> Void) {
        let endpoint = "minhas-informacoes/boletim/2024/1/"
        let finalURL = baseURL + endpoint
        let header: HTTPHeaders = [.authorization("Bearer \(userToken)")]
        AF.request(finalURL, method: .get, headers: header).responseDecodable(of: [BoletimData].self) { response in
            switch response.result {
            case .success(let sucess):
                print("Dados decodificados: \(sucess)")
                completion(.success(sucess))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum GenericError: Error {
    case genericError(message: String)
}
