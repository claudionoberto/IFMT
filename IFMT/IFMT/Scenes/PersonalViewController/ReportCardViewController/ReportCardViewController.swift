//
//  ReportCardViewController.swift
//  IFMT
//
//  Created by Claudio Noberto on 13/08/24.
//

import UIKit

class ReportCardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    
    var data: [BoletimData]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Boletim Escolar"
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        apiCall()
    }
    func apiCall() {
        APIHandler.shared.getBoletimData { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
            case .failure(let error):
                let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data != nil {
            return data!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let disciplina = data?[indexPath.row]
    
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = """
        Situação: \(disciplina?.situacao ?? "")
        Código: \(disciplina?.codigo_diario ?? "")
        Disciplina: \(disciplina?.disciplina ?? "")
        Carga Horária: \(disciplina?.carga_horaria ?? 0) horas
        Carga Horária Cumprida: \(disciplina?.carga_horaria_cumprida ?? 0) horas
        Faltas: \(disciplina?.numero_faltas ?? 0)
        Carga Horária Frequentada(%): \(disciplina?.percentual_carga_horaria_frequentada ?? 0)
        Nota Média: \(disciplina?.media_disciplina ?? "")
        """
        
        return cell
    }
}
