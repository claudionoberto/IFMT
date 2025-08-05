//
//  LoginViewController.swift
//  IFMT
//
//  Created by Claudio Noberto on 01/04/24.
//

import UIKit

class LoginViewController: UIViewController {
    private lazy var image: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "ifmtImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var usernameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Matrícula"
        textField.tintColor = UIColor.lightGray
        textField.setIcon(UIImage(systemName: "person"))
        textField.textContentType = .username
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Senha"
        textField.tintColor = UIColor.lightGray
        textField.setIcon(UIImage(systemName: "key"))
        textField.textContentType = .password
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .filled()
        button.tintColor = .systemGreen
        button.configuration?.title = "Entrar"
        button.configuration?.buttonSize = .large
        button.configuration?.cornerStyle = .medium
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
          var outgoing = incoming
          outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
          return outgoing
        }
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Login"
        
        setupViews()
    }
    
    private func setupViews() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing)))
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(enterButton)
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 180),
            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            usernameField.heightAnchor.constraint(equalToConstant: 50),
            usernameField.widthAnchor.constraint(equalTo: view.readableContentGuide.widthAnchor),
            passwordField.widthAnchor.constraint(equalTo: view.readableContentGuide.widthAnchor),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 10),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            enterButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            enterButton.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
        ])
    }
    
    @objc func tappedButton() {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let usernameText = usernameField.text, let passwordText = passwordField.text else { return }
        
        if usernameText != "" && passwordText != "" {
            APIHandler.shared.getToken(username: usernameText, password: passwordText) { [weak self] result in
                switch result {
                case .success(_):
                    self?.apiCallGeneralData()
                    let controller = TabBarController()
                    controller.selectedIndex = 3
                    controller.modalPresentationStyle = .fullScreen
                    self?.present(controller, animated: true)
                case .failure(let error):
                    let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        } else {
            let alert = UIAlertController(title: "Erro", message: "Preencha os dados", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func apiCallGeneralData() {
        APIHandler.shared.getGeneralData { [weak self] result in
            switch result {
            case .success(let data):
                UserManager.shared.matricula = data.vinculo.matricula
                UserManager.shared.nome = data.vinculo.nome
                UserManager.shared.curso = data.vinculo.curso
                UserManager.shared.campus = data.vinculo.campus
                UserManager.shared.situacao = data.vinculo.situacao
                UserManager.shared.email_qacademico = data.vinculo.email_qacademico
                print("sucesso fion")
            case .failure(let error):
                let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
}

extension UITextField {
    func setIcon(_ image1: UIImage?) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image1
        iconView.contentMode = .scaleAspectFit
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
