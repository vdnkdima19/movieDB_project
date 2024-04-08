import UIKit
import RealmSwift

class ChatsViewController: UIViewController {
    let chatsTableView = UITableView()
    var messagesArray: [(user: String, admin: String)] = []
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        realm.objects(ChatMessage.self).forEach {
            let user = $0.user
            let admin = $0.admin
            if !messagesArray.contains(where: { $0.admin == admin && $0.user == user }) {
                messagesArray.append((user: user, admin: admin))
            }
        }
        messagesArray = messagesArray.filter { searchUser in
            let user = realm.objects(User.self).filter {
                $0.username == searchUser.user
            }.first
            return !(user?.isBanned ?? true) || (user?.isRepairBanned ?? false)
        }
        
        setTitleNavBar(text: "List of appeals")
        addSubViews()
        setConstraints()
        configView()
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
        chatsTableView.backgroundColor = .darkBlue
    }
    func reloadData() {
        let realm = try! Realm()
        messagesArray = []
        realm.objects(ChatMessage.self).forEach {
            let user = $0.user
            let admin = $0.admin
            if !messagesArray.contains(where: { $0.admin == admin && $0.user == user }) {
                messagesArray.append((user: user, admin: admin))
            }
        }
        
        messagesArray = messagesArray.filter { searchUser in
            let user = realm.objects(User.self).filter {
                $0.username == searchUser.user
            }.first
            return !(user?.isBanned ?? true) || (user?.isRepairBanned ?? false)
        }
        chatsTableView.reloadData()
    }
    private func addSubViews() {
        self.view.addSubview(chatsTableView)
    }
    private func setConstraints() {
        chatsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chatsTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64),
            chatsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            chatsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            chatsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    private func configView() {
        chatsTableView.dataSource = self
        chatsTableView.delegate = self
        chatsTableView.separatorStyle = .none
    }
}
extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let userNameLabel = UILabel()
        let imageOfAvatar = UIImageView()
        let messageText = UILabel()
        let lineOfView = UIView()
        let dataOfLastMessage = UILabel()
        let checkedMessageImageView = UIImageView()
        let statusOfAccount = UILabel()
        cell.addSubview(userNameLabel)
        cell.addSubview(imageOfAvatar)
        cell.addSubview(messageText)
        cell.addSubview(lineOfView)
        cell.addSubview(dataOfLastMessage)
        cell.addSubview(checkedMessageImageView)
        cell.addSubview(statusOfAccount)
        cell.backgroundColor = .darkBlue1
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        imageOfAvatar.translatesAutoresizingMaskIntoConstraints = false
        messageText.translatesAutoresizingMaskIntoConstraints = false
        dataOfLastMessage.translatesAutoresizingMaskIntoConstraints = false
        lineOfView.translatesAutoresizingMaskIntoConstraints = false
        checkedMessageImageView.translatesAutoresizingMaskIntoConstraints = false
        statusOfAccount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageOfAvatar.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10),
            imageOfAvatar.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 6),
            imageOfAvatar.widthAnchor.constraint(equalToConstant: 60),
            imageOfAvatar.heightAnchor.constraint(equalTo: imageOfAvatar.widthAnchor, multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: imageOfAvatar.trailingAnchor, constant: 16),
            userNameLabel.topAnchor.constraint(equalTo: imageOfAvatar.topAnchor)
        ])
        NSLayoutConstraint.activate([
            statusOfAccount.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 16),
            statusOfAccount.topAnchor.constraint(equalTo: imageOfAvatar.topAnchor)
        ])
        NSLayoutConstraint.activate([
            messageText.leadingAnchor.constraint(equalTo: imageOfAvatar.trailingAnchor, constant: 16),
            messageText.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -28),
            messageText.bottomAnchor.constraint(equalTo: lineOfView.topAnchor, constant: -4),
            messageText.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            lineOfView.leadingAnchor.constraint(equalTo: imageOfAvatar.trailingAnchor),
            lineOfView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            lineOfView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            lineOfView.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            dataOfLastMessage.topAnchor.constraint(equalTo: imageOfAvatar.topAnchor),
            dataOfLastMessage.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -6)
        ])
        NSLayoutConstraint.activate([
            checkedMessageImageView.bottomAnchor.constraint(equalTo: lineOfView.topAnchor, constant: -6),
            checkedMessageImageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -6),
            checkedMessageImageView.heightAnchor.constraint(equalToConstant: 20),
            checkedMessageImageView.widthAnchor.constraint(equalTo: checkedMessageImageView.heightAnchor, multiplier: 1)
        ])
        if LoginUser.shared.user!.isRepairBanned {
            statusOfAccount.text = "(blocked)"
            statusOfAccount.textColor = .red
        }
        let userName = messagesArray[indexPath.row].user
                if let user = realm.objects(User.self).filter("username == %@", userName).first {
                    imageOfAvatar.image = UIImage(data: user.avatarImageData)
                    if user.isRepairBanned == true {
                            statusOfAccount.text = "(blocked)"
                            statusOfAccount.textColor = .red
                        }
                } else {
                    imageOfAvatar.image = UIImage(systemName: "person.circle.fill")
                }
        userNameLabel.text = messagesArray[indexPath.row].user
        userNameLabel.textColor = .white
        messageText.textColor = .systemGray
        lineOfView.backgroundColor = .black
        let lastMessage = realm.objects(ChatMessage.self)
             .filter("user == %@", userName)
             .sorted(byKeyPath: "date", ascending: false)
             .first
        if !lastMessage!.isAdmin {
            checkedMessageImageView.image = !lastMessage!.isCheckedMessage ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "checkmark.circle.fill")
        } else {
            checkedMessageImageView.image = UIImage()
        }
        messageText.text = lastMessage?.text ?? "No messages"
        messageText.numberOfLines = 0
        if let lastMessageDate = lastMessage?.date {
            let currentDate = Date()
            let timeDifference = currentDate.timeIntervalSince(lastMessageDate)
            dataOfLastMessage.textColor = .white
            if timeDifference >= 24 * 60 * 60 {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d MMM"
                dataOfLastMessage.text = dateFormatter.string(from: lastMessageDate)
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                dataOfLastMessage.text = dateFormatter.string(from: lastMessageDate)
            }
        }

        cell.selectionStyle = .none
        imageOfAvatar.layer.cornerRadius = 30
           imageOfAvatar.layer.masksToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lastMessage = realm.objects(ChatMessage.self)
            .filter("user == %@", messagesArray[indexPath.row].user)
             .sorted(byKeyPath: "date", ascending: false)
             .first
        try! realm.write {
            lastMessage?.isCheckedMessage = true
        }
        navigationController?.pushViewController(HelpFAQViewController(userName: messagesArray[indexPath.row].user, adminName: LoginUser.shared.user!.username), animated: true)
    }
}
