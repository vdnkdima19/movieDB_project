import UIKit
import RealmSwift

class MovieTabBarController: UITabBarController {
    static var shared = MovieTabBarController()
    let notificationView = UIView(frame: CGRect (x: 200, y: 785, width: 18, height: 18))
    
    var countNewNoticationLabel = UILabel()
    public func configTabBar() {
        self.viewControllers = []
        self.viewControllers = [NavigationController(), NotificationViewController(), AccountViewController()]
        viewControllers?[0].tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ImageFirstTabBar")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ImageFirstTabBarSelect"))
        viewControllers?[1].tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ImageSecondTabBar")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ImageSecondTabBarSelect"))
        viewControllers?[2].tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ImageThirdTabBar")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ImageThirdTabBarSelect"))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
        self.tabBar.backgroundColor = .darkBlue
        countNewNoticationLabel = UILabel(frame: CGRect (x: (notificationView.frame.width - 10)/2, y: (notificationView.frame.height - 12)/2, width: 12, height: 12))
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.8))
        lineView.backgroundColor = .black
        tabBar.addSubview(lineView)
        self.view.addSubview(notificationView)
        notificationView.layer.cornerRadius = 9
        notificationView.clipsToBounds = true
        notificationView.addSubview(countNewNoticationLabel)
        setConstaints()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        reloadCountOfNotificationMessage()
    }
    public func setConstaints() {
        [notificationView,countNewNoticationLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        countNewNoticationLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            notificationView.centerYAnchor.constraint(equalTo: self.tabBar.centerYAnchor,constant: -2),
            notificationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 10),
            notificationView.widthAnchor.constraint(equalToConstant: 18),
            notificationView.heightAnchor.constraint(equalToConstant: 18)
        ])
        NSLayoutConstraint.activate([
            countNewNoticationLabel.topAnchor.constraint(equalTo: notificationView.topAnchor),
            countNewNoticationLabel.leadingAnchor.constraint(equalTo: notificationView.leadingAnchor),
            countNewNoticationLabel.bottomAnchor.constraint(equalTo: notificationView.bottomAnchor),
            countNewNoticationLabel.trailingAnchor.constraint(equalTo: notificationView.trailingAnchor)
        ])
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
