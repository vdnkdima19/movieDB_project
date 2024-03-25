import UIKit
import RealmSwift

class HelpFAQViewController: UIViewController {
    let sendButton = UIButton()
    let messageTextField = UITextField()
    let chatTableView = UITableView()
    let userName: String
    let adminName: String
    var messagesArray: [ChatMessage]
    var adminImage = UIImage()
    var userImage = UIImage()
    var lastClickTime: Date?
    let bannedButton = UIButton()
    
    var user: User!
    init(userName: String, adminName: String) {
        self.userName = userName
        self.adminName = adminName
        let realm = try! Realm()
        messagesArray = realm.objects(ChatMessage.self).where({
            $0.user == userName
        }).filter({ _ in true }).sorted(by: {
            $0.messageId < $1.messageId
        })
        adminImage = UIImage(data: realm.objects(User.self).where( { $0.username == adminName }).first?.avatarImageData ?? Data()) ?? UIImage()
        userImage = UIImage(data: realm.objects(User.self).where( { $0.username == userName }).first?.avatarImageData ?? Data()) ?? UIImage()
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setConstraints()
        checkAdmin()
        configButtonBanned()
        visualConfigElements()
        configElements()
        chatTableView.backgroundColor = .darkBlue1
        DispatchQueue.main.async {
            let lastSectionIndex = self.chatTableView.numberOfSections - 1
            let lastRowIndex = self.chatTableView.numberOfRows(inSection: lastSectionIndex) - 1
            if lastSectionIndex >= 0 && lastRowIndex >= 0 {
                self.chatTableView.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: false)
            }
        }
    }
    private func checkAdmin() {
        if LoginUser.shared.user!.isAdmin {
            self.setTitleNavBar(text: userName)
        } else {
            self.setTitleNavBar(text: adminName)
        }
    }
    private func configElements() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageTableViewCell")
        chatTableView.register(CurrentUserMessageTableViewCell.self, forCellReuseIdentifier: "CurrentUserMessageTableViewCell")
        chatTableView.separatorStyle = .none
        sendButton.addTarget(self, action: #selector(sendButtonIsPressed), for: .touchUpInside)
        
    }
    
    @objc private func bannedButtonIsPressed() {
        let realm = try! Realm()
        
        let findUser = realm.objects(User.self).first(where: {
            $0.username == self.userName
        })
        
        if !(findUser?.isAdmin ?? true) {
            try! realm.write {
                findUser?.isBanned = true
            }
            let findedUser = realm.objects(User.self).first(where: {
                $0.username == self.userName
            })
            try! realm.write {
                findedUser?.isBanned = true
                findedUser?.isRepairBanned = true
            }
        }
        let alertController = UIAlertController(title: "Ban",message: "\(userName) has been banned. Reason: Violation of community guidelines",preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(okayAction)
            if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                viewController.present(alertController, animated: true, completion: nil)
            }
            return
    }
    
    @objc private func sendButtonIsPressed() {
        guard let inputText = messageTextField.text, !inputText.isEmpty else {
                let alertController = UIAlertController(title: "Warning", message: "Your message is empty", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                }
                alertController.addAction(okayAction)
                if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                    viewController.present(alertController, animated: true, completion: nil)
                }
                return
            }

            let regexPattern = "(?i)\\b([a-z]*stupid[a-z]*|[a-z]*bugger[a-z]*|[a-z]*arse[a-z]*|[a-z]*crap[a-z]*)\\b"
            let httpRegexPattern = "\\b[A-Za-z]*(http[s]?://\\S+)\\b"

        do {
                let regex = try NSRegularExpression(pattern: regexPattern, options: [])
                let httpRegex = try NSRegularExpression(pattern: httpRegexPattern, options: [])

                let httpMatches = httpRegex.matches(in: inputText, options: [], range: NSRange(location: 0, length: inputText.utf16.count))
                if httpMatches.count > 0 {
                    let alertController = UIAlertController(title: "Warning", message: "Your review contains HTTP links, which are not allowed", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                        self?.messageTextField.text = ""
                    }
                    alertController.addAction(okayAction)
                    if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                        viewController.present(alertController, animated: true, completion: nil)
                    }
                    return
                }

                let matches = regex.matches(in: inputText, options: [], range: NSRange(location: 0, length: inputText.utf16.count))
                if matches.count > 0 {
                    let alertController = UIAlertController(title: "Warning", message: "Your message contains prohibited words", preferredStyle: .alert)

                    let okayAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                        self?.messageTextField.text = ""
                    }
                    alertController.addAction(okayAction)
                    if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                        viewController.present(alertController, animated: true, completion: nil)
                    }
                    return
                }
            let realm = try! Realm()
            let currentTime = Date()
            
            if let lastClickTime = self.lastClickTime {
                let timeDifference = currentTime.timeIntervalSince(lastClickTime)
                if timeDifference < 5 {   let alertController = UIAlertController(title: "Spam",message: "You've performed this action too quickly. Please wait a moment before trying again",preferredStyle: .alert)
                    
                    let okayAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                    }
                    alertController.addAction(okayAction)
                    if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                        viewController.present(alertController, animated: true, completion: nil)
                    }
                    return
                }
            }
            
            self.lastClickTime = currentTime
            let newMessage = ChatMessage()
            newMessage.isAdmin = LoginUser.shared.user!.isAdmin
            newMessage.admin = adminName
            newMessage.user = userName
            newMessage.text = messageTextField.text ?? ""
            newMessage.messageId = messagesArray.count
            try! realm.write {
                realm.add(newMessage)
            }
            
            messagesArray = realm.objects(ChatMessage.self).where({
                $0.user == userName
            }).filter({ _ in true }).sorted(by: {
                $0.messageId < $1.messageId
            })
            chatTableView.reloadData()
            messageTextField.text = ""
            DispatchQueue.main.async {
                let lastSectionIndex = self.chatTableView.numberOfSections - 1
                let lastRowIndex = self.chatTableView.numberOfRows(inSection: lastSectionIndex) - 1
                if lastSectionIndex >= 0 && lastRowIndex >= 0 {
                    self.chatTableView.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: true)
                }
            }
        } catch {
                print("Error creating regex: \(error.localizedDescription)")
            }
    }
    private func addSubViews() {
        self.view.addSubview(chatTableView)
        self.view.addSubview(messageTextField)
        self.view.addSubview(sendButton)
        self.view.addSubview(bannedButton)
    }
    
    private func setConstraints() {
        [chatTableView, messageTextField, sendButton, bannedButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sendButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            bannedButton.bottomAnchor.constraint(equalTo: messageTextField.topAnchor, constant: -8),
            bannedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            bannedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            bannedButton.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            messageTextField.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -8),
            messageTextField.leadingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.trailingAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: messageTextField.topAnchor, constant: -8)
        ])
    }
    
    private func configButtonBanned() {
        if LoginUser.shared.user?.isAdmin ?? false {
            bannedButton.layer.cornerRadius = 10
            bannedButton.backgroundColor = .red
            bannedButton.setTitleColor(.white, for: .normal)
            bannedButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
            bannedButton.setTitle("Ban", for: .normal)
        }
        bannedButton.addTarget(self, action: #selector(bannedButtonIsPressed), for: .touchUpInside)
    }
    
    private func visualConfigElements() {
            sendButton.layer.cornerRadius = 5
            sendButton.backgroundColor = .crimson
            sendButton.setTitleColor(.white, for: .normal)
            sendButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
            sendButton.setTitle("Send", for: .normal)
        
            messageTextField.leftViewMode = .always
            messageTextField.layer.borderColor = UIColor.defaultBorderColor
            messageTextField.layer.borderWidth = 1.0
            messageTextField.backgroundColor = .darkBlue
            messageTextField.textColor = .white
            messageTextField.layer.cornerRadius = 5
            
            let placeholderText = "Enter message"
            let placeholderColor = UIColor.systemGray
            let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
            messageTextField.attributedPlaceholder = attributedPlaceholder
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}

extension HelpFAQViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messagesArray[indexPath.row]
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormater.string(from: message.date)
        if LoginUser.shared.user!.isAdmin && message.isAdmin || !LoginUser.shared.user!.isAdmin && !message.isAdmin {
            if let cell = chatTableView.dequeueReusableCell(withIdentifier: "CurrentUserMessageTableViewCell", for: indexPath) as? CurrentUserMessageTableViewCell {
                cell.configCell(message: message.text, date: date, avatarImage: message.isAdmin ? adminImage : userImage)
                return cell
            }
        } else {
            if let cell = chatTableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as? MessageTableViewCell {
                cell.configCell(message: message.text, date: date, avatarImage: message.isAdmin ? adminImage : userImage)
                return cell
            }
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
