//
//  UserManager.swift
//  IFMT
//
//  Created by Claudio Noberto on 16/08/24.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    private init() {}
    
    var matricula: String?
    var nome: String?
    var curso: String?
    var campus: String?
    var situacao: String?
    var email_qacademico: String?
}
