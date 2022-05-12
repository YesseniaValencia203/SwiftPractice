import UIKit

class TabBarController: UITabBarController {
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var tabController: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        navItem.title = item.title
    }
}

