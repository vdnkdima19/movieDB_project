import UIKit

extension UIViewController {
    /// Встановлює title для navigationController та змінює його колір заднього фону та віттінок
    public func setTitleNavBar(text: String) {
        self.navigationController?.navigationBar.isHidden = false
        let titleLabel = UILabel()
            titleLabel.text = text
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = .white
            titleLabel.sizeToFit()
            self.navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .darkBlue
        self.navigationController?.navigationBar.barTintColor = .darkBlue
    }
}
