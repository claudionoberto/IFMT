//
//  Models.swift
//  IFMT
//
//  Created by Claudio Noberto on 01/04/24.
//

import Foundation

struct GeneralData: Codable {
    let vinculo: Vinculos
}

struct Vinculos: Codable {
    let matricula: String
    let nome: String
    let curso: String
    let campus: String
    let situacao: String
    let email_qacademico: String
}

struct BoletimData: Codable {
    let codigo_diario: String
    let disciplina: String
    let carga_horaria: Int
    let carga_horaria_cumprida: Int
    let numero_faltas: Int
    let percentual_carga_horaria_frequentada: Double
    let situacao: String
    let media_disciplina: String
}
