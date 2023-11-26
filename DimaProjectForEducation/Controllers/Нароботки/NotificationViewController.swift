import UIKit

class NotificationViewController: UIViewController {
    let notificationLabel = UILabel()
    let lineOfView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setConstraions()
        configNotificationLabel()
    }
    private func addSubViews() {
        [notificationLabel,lineOfView].forEach {
            self.view.addSubview($0)
        }
    }
    private func setConstraions(){
        [notificationLabel,lineOfView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            notificationLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 65),
            notificationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18)
        ])
        NSLayoutConstraint.activate([
            lineOfView.topAnchor.constraint(equalTo: self.notificationLabel.bottomAnchor),
            lineOfView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            lineOfView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            lineOfView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    private func configNotificationLabel(){
        notificationLabel.textColor = .white
        notificationLabel.font = UIFont(name: "Heebo-SemiBold", size: 24)
        notificationLabel.text = "Notifications" 
        lineOfView.backgroundColor = .black
    }
}
