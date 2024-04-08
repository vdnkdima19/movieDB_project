import UIKit
import RealmSwift

class MainNavigationController: UINavigationController {
    let loginVC = LoginVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pushViewController(loginVC, animated: false)
        self.view.backgroundColor = .darkBlue
        self.navigationBar.isHidden = true
        self.isFirstLogin()
        self.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func isFirstLogin() {
        if !UserDefaults.standard.bool(forKey: "isNotFirstLogin") {
            createAdmin()
            UserDefaults.standard.set(true, forKey: "isNotFirstLogin")
        }
    }
    private func createAdmin() {
        let realm = try! Realm()
        // Створення нового об'єкту User
        let newUser = User()
        newUser.username = "Admin"
        newUser.password = "Admin"
        newUser.isAdmin = true
        newUser.isBanned = false
        newUser.isRepairBanned = false
        newUser.bannedDescription = ""
        newUser.avatarImageData = UIImage(systemName: "person.badge.key")?.jpegData(compressionQuality: 1) ?? Data()
        // Збереження об'єкту User в Realm
        try! realm.write {
            realm.add(newUser)
        }
    }
    func hideNavigationBar() {
        self.setNavigationBarHidden(true, animated: true)
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
