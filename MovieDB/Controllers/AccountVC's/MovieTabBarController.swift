import UIKit
import RealmSwift

class MovieTabBarController: UITabBarController {
    static var shared = MovieTabBarController()
    var notificationView = UIView(frame: CGRect (x: 200, y: 25, width: 18, height: 18))
    
    var countNewNoticationLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .darkBlue
        countNewNoticationLabel = UILabel(frame: CGRect (x: (notificationView.frame.width - 10)/2, y: (notificationView.frame.height - 12)/2, width: 12, height: 12))
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.8))
        lineView.backgroundColor = .black
        tabBar.addSubview(lineView)
        let firstViewController = NavigationController()
        let firstTabImage = UIImage(named: "ImageFirstTabBar")
        let firstTabSelectedImage = UIImage(named: "ImageFirstTabBarSelect")
        let transparentFirstTabImage = firstTabImage?.withRenderingMode(.alwaysOriginal)
        let transparentFirstTabSelectedImage = firstTabSelectedImage?.withRenderingMode(.alwaysOriginal)
        firstViewController.tabBarItem = UITabBarItem(title: "", image: transparentFirstTabImage, selectedImage: transparentFirstTabSelectedImage)
//        firstViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ImageFirstTabBar"), selectedImage: UIImage(named: "ImageFirstTabBarSelect"))
        let secondViewController = NotificationViewController()
        let secondTabImage = UIImage(named: "ImageSecondTabBar")
        let secondTabSelectedImage = UIImage(named: "ImageSecondTabBarSelect")
        let transparentSecondTabImage = secondTabImage?.withRenderingMode(.alwaysOriginal)
        let transparentSecondTabSelectedImage = secondTabSelectedImage?.withRenderingMode(.alwaysOriginal)
        secondViewController.tabBarItem = UITabBarItem(title: "", image: transparentSecondTabImage, selectedImage: transparentSecondTabSelectedImage)
//        secondViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ImageSecondTabBar"), selectedImage: UIImage(named: "ImageSecondTabBarSelect"))
        let thirdViewController = AccountViewController()
        let thirdTabImage = UIImage(named: "ImageThirdTabBar")
        let thirdTabSelectedImage = UIImage(named: "ImageThirdTabBarSelect")
        let transparentThirdTabImage = thirdTabImage?.withRenderingMode(.alwaysOriginal)
        let transparentThirdTabSelectedImage = thirdTabSelectedImage?.withRenderingMode(.alwaysOriginal)
        thirdViewController.tabBarItem = UITabBarItem(title: "", image: transparentThirdTabImage, selectedImage: transparentThirdTabSelectedImage)
//        thirdViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ImageThirdTabBar"), selectedImage: UIImage(named: "ImageThirdTabBarSelect"))
        viewControllers = [firstViewController,secondViewController,thirdViewController]
       
        tabBar.addSubview(notificationView)
        notificationView.layer.cornerRadius = 9
        notificationView.clipsToBounds = true
        notificationView.addSubview(countNewNoticationLabel)
        reloadCountOfNotificationMessage()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    public func reloadCountOfNotificationMessage() {
        let realm = try! Realm()
        let uncheckedComments = realm.objects(Comments.self).where({
            $0.userName == LoginUser.shared.user?.username ?? "" && !$0.isCheckedNotification
        })
        countNewNoticationLabel.text = "\(uncheckedComments.count)"
        if uncheckedComments.count != 0 {
            if uncheckedComments.count > 9 {
                countNewNoticationLabel.text = "9"
            } else {
                countNewNoticationLabel.text = "\(uncheckedComments.count)"
            }
            countNewNoticationLabel.textColor = .white
            notificationView.backgroundColor = .red
        } else {
            countNewNoticationLabel.text = ""
            countNewNoticationLabel.textColor = .clear
            notificationView.backgroundColor = .clear
        }
    }
}

