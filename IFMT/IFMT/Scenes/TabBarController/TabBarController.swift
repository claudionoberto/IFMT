//
//  TabBarController.swift
//  IFMT
//
//  Created by Claudio Noberto on 01/04/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemGreen

        viewControllers = [createNavController(for: NewsViewController(), tabBartitle: "Notícias", tabBarimage: UIImage(systemName: "newspaper"), navigationTitle: ""),
                           createNavController(for: MenuViewController(), tabBartitle: "Cardápio", tabBarimage: UIImage(systemName: "menucard"), navigationTitle: "Cardápio"),
                           createViewController(for: MapViewController(), tabBartitle: "Mapa", tabBarimage: UIImage(systemName: "map")),
                           createNavController(for: PersonalViewController(), tabBartitle: "Pessoal", tabBarimage: UIImage(systemName: "person.crop.circle"), navigationTitle: "Pessoal"),
                           createNavController(for: ForumViewController(), tabBartitle: "Fórum", tabBarimage: UIImage(systemName: "person.2"), navigationTitle: "Fórum")]

    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     tabBartitle: String?,
                                     tabBarimage: UIImage?,
                                     navigationTitle: String?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = tabBartitle
        navController.tabBarItem.image = tabBarimage
        rootViewController.navigationItem.title = navigationTitle
        return navController
    }
    
    private func createViewController(for rootViewController: UIViewController,
                                     tabBartitle: String?,
                                     tabBarimage: UIImage?) -> UIViewController {
        let navController = rootViewController
        navController.tabBarItem.title = tabBartitle
        navController.tabBarItem.image = tabBarimage
        return navController
    }
}
