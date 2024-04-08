import UIKit

class NavigationController: UINavigationController {
    let movievc = MovieVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pushViewController(movievc, animated: false)
        self.view.backgroundColor = .darkBlue
        self.navigationBar.isHidden = true
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
