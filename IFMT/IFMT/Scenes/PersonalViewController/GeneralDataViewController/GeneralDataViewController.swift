//
//  GeneralDataViewController.swift
//  IFMT
//
//  Created by Claudio Noberto on 01/04/24.
//

import UIKit

class GeneralDataViewController: UITableViewController {
    
    lazy var loadingAnimation: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        navigationItem.largeTitleDisplayMode = .never
        tableView.register(GeneralDataTableViewCell.self, forCellReuseIdentifier: GeneralDataTableViewCell.identifier)
        tableView.allowsSelection = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GeneralDataTableViewCell.identifier, for: indexPath) as? GeneralDataTableViewCell else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            cell.labelText.text = "Nome"
            cell.labelText2.text = UserManager.shared.nome
        case 1:
            cell.labelText.text = "Curso"
            cell.labelText2.text = UserManager.shared.curso
        case 2:
            cell.labelText.text = "Matrícula"
            cell.labelText2.text = UserManager.shared.matricula
        case 3:
            cell.labelText.text = "Campus"
            cell.labelText2.text = UserManager.shared.campus
        case 4:
            cell.labelText.text = "Situação"
            cell.labelText2.text = UserManager.shared.situacao
        case 5:
            cell.labelText.text = "E-mail"
            cell.labelText2.text = UserManager.shared.email_qacademico
        default:
            ()
        }
        
        return cell
    }
}
