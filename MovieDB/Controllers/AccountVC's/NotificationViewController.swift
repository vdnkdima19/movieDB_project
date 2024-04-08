import UIKit
import RealmSwift

class NotificationViewController: UIViewController {
    let notificationLabel = UILabel()
    let lineOfView = UIView()
    let commentsNotificationsTableView = UITableView()
    var commentNotificationsArray: [Comments] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsNotificationsTableView.delegate = self
        commentsNotificationsTableView.dataSource = self
        commentsNotificationsTableView.register(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
        commentsNotificationsTableView.backgroundColor = .darkBlue
        addSubViews()
        setConstraions()
        configNotificationLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        addNotifications()
        commentsNotificationsTableView.reloadData()
        MovieTabBarController.shared.reloadCountOfNotificationMessage()
    }
    private func addNotifications() {
        let realm = try! Realm()
        let comments = realm.objects(Comments.self).where({
            $0.isCheckedNotification == false && $0.userName == LoginUser.shared.user?.username ?? "" && $0.status != 0
        })
        commentNotificationsArray = comments.filter({ _ in true })
        
        let uncheckedComments = realm.objects(Comments.self).where({
            $0.userName == LoginUser.shared.user?.username ?? "" && !$0.isCheckedNotification
        })
        
        uncheckedComments.forEach {
            let comment = $0
            try! realm.write {
                comment.isCheckedNotification = true
            }
        }
    }
    private func addSubViews() {
        [notificationLabel, lineOfView, commentsNotificationsTableView].forEach {
            self.view.addSubview($0)
        }
    }
    private func setConstraions(){
        [notificationLabel, lineOfView, commentsNotificationsTableView].forEach{
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
        NSLayoutConstraint.activate([
            commentsNotificationsTableView.topAnchor.constraint(equalTo: lineOfView.bottomAnchor, constant: 16),
            commentsNotificationsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            commentsNotificationsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            commentsNotificationsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    private func configNotificationLabel(){
        notificationLabel.textColor = .white
        notificationLabel.font = UIFont(name: "Heebo-SemiBold", size: 24)
        notificationLabel.text = "Notifications"
        lineOfView.backgroundColor = .black
    }
}
extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentNotificationsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell {
            cell.configCell(comment: commentNotificationsArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }
}
