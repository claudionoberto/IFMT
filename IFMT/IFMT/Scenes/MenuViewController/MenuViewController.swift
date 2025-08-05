//
//  MenuViewController.swift
//  IFMT
//
//  Created by Claudio Noberto on 01/04/24.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let menuItems = [
        ("Arroz e Feijão", "Arroz branco, feijão preto, carne assada e salada"),
        ("Macarrão ao Molho", "Macarrão com molho de tomate e queijo parmesão"),
        ("Sopa de Legumes", "Sopa de legumes com pedaços de frango"),
        ("Salada de Frutas", "Salada de frutas frescas da estação"),
        ("Omelete", "Omelete com queijo, presunto e ervas")
    ]
    
    let dias = ["Segunda-feira","Terça-feira","Quarta-feira","Quinta-feira","Sexta-feira"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: "cell")

        
        view.addSubview(tableView)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuItemCell
        let menuItem = menuItems[indexPath.section]
        cell.titleLabel.text = menuItem.0
        cell.descriptionLabel.text = menuItem.1
        return cell
    }
     
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 44
     }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = dias[section]
        label.font = .boldSystemFont(ofSize: 22)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let headerView = UIView()
        headerView.addSubview(label)
        label.leftAnchor.constraint(equalTo: headerView.leftAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5).isActive = true

        return headerView
    }

}

class MenuItemCell: UITableViewCell {
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
