//
//  ForumTextFieldViewController.swift
//  IFMT
//
//  Created by Claudio Noberto on 15/08/24.
//

import UIKit
import Supabase

struct NewPost: Encodable {
    let name: String
    let description: String
}

class ForumTextFieldViewController: UIViewController, UITextViewDelegate {
    
    private let textView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 20)
        view.isScrollEnabled = true
        view.autocapitalizationType = .sentences
        view.autocorrectionType = .yes
        view.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return view
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite algo..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .lightGray
        return label
    }()
    
    weak var delegate: SecondViewControllerDelegate?
    
    // Supabase Client
    let client = SupabaseClient(supabaseURL: URL(string: "https://jqrrixmzwaruxdsrmncv.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpxcnJpeG16d2FydXhkc3JtbmN2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM2NDc5MzMsImV4cCI6MjAzOTIyMzkzM30.j47cXyM8s2NnpeDqJVWDelxrI0WCG6cx532ufVlNuB4")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Novo Post"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .systemGreen

        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem = cancelButton
        
    
        let okButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(okTapped))
        navigationItem.rightBarButtonItem = okButton
       
        view.addSubview(textView)
        view.addSubview(placeholderLabel)
        textView.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 10),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 15)
        ])
        
        textView.delegate = self
        updatePlaceholderVisibility()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func okTapped() {
        print("Texto digitado: \(textView.text ?? "")")
        guard let description = textView.text else {
            print("description is empty")
            return
        }

        Task {
            await addPost(name: UserManager.shared.nome!, description: description)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholderVisibility()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        updatePlaceholderVisibility()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updatePlaceholderVisibility()
    }
    
    func addPost(name: String, description: String) async {
        let newPost = NewPost(name: name, description: description)

        do {
            let response: PostgrestResponse<Void> = try await client.database.from("posts").insert(newPost).execute()

            if response.status == 201 {
                print("Post adicionado com sucesso!")
                delegate?.didDismissWithPost()
            } else {
                print("Erro Status: \(response.status)")
            }
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
