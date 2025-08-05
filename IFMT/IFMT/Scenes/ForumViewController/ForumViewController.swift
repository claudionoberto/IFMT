//
//  ForumViewController.swift
//  IFMT
//
//  Created by Claudio Noberto on 01/04/24.
//

import UIKit
import Supabase

struct Post: Decodable {
    let id: UUID
    let name: String
    let description: String
    let created_at: Date
}

protocol SecondViewControllerDelegate: AnyObject {
    func didDismissWithPost()
}

class ForumViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SecondViewControllerDelegate {
    
    func didDismissWithPost() {
        Task {
            await loadPosts()
        }
    }
    

    // Supabase Client
    let client = SupabaseClient(supabaseURL: URL(string: "https://jqrrixmzwaruxdsrmncv.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpxcnJpeG16d2FydXhkc3JtbmN2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM2NDc5MzMsImV4cCI6MjAzOTIyMzkzM30.j47cXyM8s2NnpeDqJVWDelxrI0WCG6cx532ufVlNuB4")

    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        Task {
            await loadPosts()
        }
    }

    func setupUI() {
        view.backgroundColor = .white
        addButton()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = 10
        tableView.sectionHeaderHeight = 10
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        view.addSubview(tableView)
        tableView.register(ForumViewCell.self, forCellReuseIdentifier: "cell")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addButton() {
        let backButton = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .systemGreen
    }
    
    
    @objc func buttonTapped() {
        let secondVC = ForumTextFieldViewController()
        secondVC.delegate = self
        let navController = UINavigationController(rootViewController: secondVC)
        present(navController, animated: true, completion: nil)
    }
    
    func loadPosts() async {
        do {
            let response: PostgrestResponse<[Post]> = try await client.database
                .from("posts")
                .select()
                .order("created_at", ascending: false)
                .execute()

            self.posts = response.value
            tableView.reloadData()

        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ForumViewCell
        let post = posts[indexPath.section]
        cell.titleLabel.text = post.name
        cell.descriptionLabel.text = post.description
        return cell
    }

}

class ForumViewCell: UITableViewCell {
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
