//This code sets up the basic structure and appearance of a tab bar interface with four tabs, each containing a navigation stack with a root view controller. The specific behavior and appearance of each view controller can be customized further by modifying the relevant classes.

import UIKit

//This code defines a custom UITabBarController subclass named TabBarViewController.
class TabBarViewController: UITabBarController {
    //When an instance of TabBarViewController is loaded, it creates and configures four view controllers:                      HomeViewController, ExploreViewController, NotificationsViewController, and ProfileViewController.
    //Each of these view controllers is embedded in a UINavigationController instance.

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = HomeViewController()
        let vc2 = ExploreViewController()
        let vc3 = NotificationsViewController()
        let vc4 = ProfileViewController()
        
//   sets the title and navigationItem.largeTitleDisplayMode properties of each view controller to specify the title of the tab and whether the title should be displayed in a large title area at the top of the navigation bar.
        
        vc1.title = "Browse"
        vc2.title = "Search"
        vc3.title = "Notifications"
        vc4.title = "Profile"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        vc4.navigationItem.largeTitleDisplayMode = .always

//  creates an array of UINavigationController instances and sets it as the viewControllers property of the UITabBarController instance, which causes the tabs to be displayed in the tab bar.
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
//  sets the navigationBar.tintColor property of each UINavigationController instance to a label color,
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        nav4.navigationBar.tintColor = .label
        
// creates UITabBarItem objects for each tab with a title and an image.
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "heart.fill"), tag: 1)
        nav4.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        nav4.navigationBar.prefersLargeTitles = true
        
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
       
    }
  
}
   

