//
//  AlbumTabBarController.swift
//  TopAlbums
//
//  Created by Consultant on 2/27/22.
//

import UIKit

class AlbumTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupViewControllers()
    }
    func setupViewControllers() {
        viewControllers = [
            createNavController(for: FirstTabViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: SecondTabViewController(), title: NSLocalizedString("Albums", comment: ""), image: UIImage(systemName: "star")!)
        ]
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }

}
