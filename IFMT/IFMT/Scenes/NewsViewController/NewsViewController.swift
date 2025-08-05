//
//  NewsViewController.swift
//  IFMT
//
//  Created by Claudio Noberto on 01/04/24.
//

import UIKit
import WebKit

class NewsViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        webView.load(URLRequest(url: URL(string: "https://www.google.com/search?q=ifmt+octayde+noticias&sca_esv=2f8531f1ec6b81d5&sca_upv=1&biw=1920&bih=909&tbm=nws&ei=OkuoZuWGDdbY1sQPrLqA6Aw&ved=0ahUKEwjli4Sv182HAxVWrJUCHSwdAM0Q4dUDCA4&uact=5&oq=ifmt+octayde+noticias&gs_lp=Egxnd3Mtd2l6LW5ld3MiFWlmbXQgb2N0YXlkZSBub3RpY2lhczIIEAAYgAQYogQyCBAAGIAEGKIEMggQABiABBiiBDIIEAAYgAQYogQyCBAAGIAEGKIESK4SUI0GWLARcAB4AJABAJgBnAGgAYcJqgEDMC45uAEDyAEA-AEBmAIHoAKkB8ICBRAAGIAEwgIGEAAYBxgewgIIECEYoAEYwwSYAwCIBgGSBwMwLjegB8EW&sclient=gws-wiz-news")!))
        
        addBackButton()
    }
    
    private func addBackButton() {
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .systemGreen
    }
    
    @objc private func backButtonTapped() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
