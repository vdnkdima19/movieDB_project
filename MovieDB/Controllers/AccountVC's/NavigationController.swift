import UIKit

class NavigationController: UINavigationController {
    let movievc = MovieVC()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pushViewController(movievc, animated: false)
        self.view.backgroundColor = .darkBlue
        self.navigationBar.isHidden = true
      //  self.navigationController?.navigationBar.isHidden = true
        
            // self.interactivePopGestureRecognizer?.isEnabled = false
    }
//    func hideNavigationBar() {
//        self.setNavigationBarHidden(true, animated: true)
//    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
