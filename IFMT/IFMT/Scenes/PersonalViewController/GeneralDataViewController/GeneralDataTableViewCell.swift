//
//  GeneralDataTableViewCell.swift
//  IFMT
//
//  Created by Claudio Noberto on 01/04/24.
//

import UIKit

class GeneralDataTableViewCell: UITableViewCell {
    
    static let identifier = "GeneralDataCell"
    
    lazy var labelText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelText2: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(labelText)
        contentView.addSubview(labelText2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            labelText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            labelText2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelText2.leadingAnchor.constraint(equalTo: labelText.trailingAnchor, constant: 10),
            labelText2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }

}
