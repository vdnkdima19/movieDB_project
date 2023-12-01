import UIKit
import RealmSwift

class HelpFAQViewController: UIViewController {
    let sendButton = UIButton()
    let messageTextField = UITextField()
    let chatTableView = UITableView()
    
    let userName: String
    let adminName: String
    var messagesArray: [ChatMessage]
    
    init(userName: String, adminName: String) {
        self.userName = userName
        self.adminName = adminName
        let realm = try! Realm()
        messagesArray = realm.objects(ChatMessage.self).where({
            $0.user == userName
        }).filter({ _ in true }).sorted(by: {
            $0.messageId < $1.messageId
        })
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setConstraints()
        visualConfigElements()
        configElements()
    }
    
    private func configElements() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageTableViewCell")
        chatTableView.register(CurrentUserMessageTableViewCell.self, forCellReuseIdentifier: "CurrentUserMessageTableViewCell")
        chatTableView.separatorStyle = .none
        sendButton.addTarget(self, action: #selector(sendButtonIsPressed), for: .touchUpInside)
    }
    
    @objc private func sendButtonIsPressed() {
        if !messageTextField.text!.isEmpty {
            let realm = try! Realm()
            
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
        }
    }
    private func addSubViews() {
        self.view.addSubview(chatTableView)
        self.view.addSubview(messageTextField)
        self.view.addSubview(sendButton)
    }
    
    private func setConstraints() {
        [chatTableView, messageTextField, sendButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sendButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        NSLayoutConstraint.activate([
            messageTextField.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -8),
            messageTextField.leadingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.trailingAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: messageTextField.topAnchor, constant: -8)
        ])
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
        messageTextField.placeholder = "Enter message"
    }
}

extension HelpFAQViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if LoginUser.shared.user!.isAdmin {
            if let cell = chatTableView.dequeueReusableCell(withIdentifier: "CurrentUserMessageTableViewCell", for: indexPath) as? CurrentUserMessageTableViewCell {
                let message = messagesArray[indexPath.row]
                cell.configCell(message: message.text)
                return cell
            }
        } else {
            if let cell = chatTableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as? MessageTableViewCell {
                let message = messagesArray[indexPath.row]
                cell.configCell(message: message.text)
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
