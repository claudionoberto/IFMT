//
//  PersonalViewController.swift
//  IFMT
//
//  Created by Claudio Noberto on 01/04/24.
//

import UIKit

class PersonalViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemGreen
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Dados Gerais"
            cell.imageView?.image = UIImage(systemName: "person.text.rectangle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        case 1:
            cell.textLabel?.text = "Boletim"
            cell.imageView?.image = UIImage(systemName: "list.bullet.rectangle.portrait")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        default:
            ()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let controller = GeneralDataViewController()
            controller.title = "Dados gerais"
            navigationController?.pushViewController(controller, animated: true)
        case 1:
            let controller = ReportCardViewController()
            controller.title = "Boletim"
            navigationController?.pushViewController(controller, animated: true)
        default:
            ()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let imageViewSize: CGFloat = 100
        imageView.layer.cornerRadius = imageViewSize / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGreen

        headerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageViewSize),
            imageView.heightAnchor.constraint(equalToConstant: imageViewSize)
        ])

        return headerView
    }
}
