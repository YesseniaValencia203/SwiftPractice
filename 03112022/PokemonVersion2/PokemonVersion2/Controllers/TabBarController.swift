//
//  TabBarController.swift
//  PokemonVersion2
//
//  Created by Consultant on 3/11/22.
//

import UIKit

class TabBarController: UITabBarController {
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var tabController: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        navItem.title = item.title
    }
}

