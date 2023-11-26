import UIKit

class MovieTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .darkBlue
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.8))
        lineView.backgroundColor = .black
        tabBar.addSubview(lineView)
        let firstViewController = NavigationController()
        firstViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ImageFirstTabBar"), selectedImage: UIImage(named: "ImageFirstTabBarSelect"))
        let secondViewController = NotificationViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ImageSecondTabBar"), selectedImage: UIImage(named: "ImageSecondTabBarSelect"))
        let thirdViewController = AccountViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ImageThirdTabBar"), selectedImage: UIImage(named: "ImageThirdTabBarSelect"))
        viewControllers = [firstViewController,secondViewController,thirdViewController]
        
    }
}

