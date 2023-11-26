import UIKit
import RealmSwift

class ChatsViewController: UIViewController {
    let chatsTableView = UITableView()
    var messagesArray: [(user: String, admin: String)] = []
    
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
        
        
        addSubViews()
        setConstraints()
        configView()
    }
    
    private func addSubViews() {
        self.view.addSubview(chatsTableView)
    }
    private func setConstraints() {
        chatsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chatsTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32),
            chatsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            chatsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
            chatsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32)
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
        cell.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -16),
            userNameLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
        ])
        
        userNameLabel.text = messagesArray[indexPath.row].user
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(HelpFAQViewController(userName: messagesArray[indexPath.row].user, adminName: LoginUser.shared.user!.username), animated: true)
    }
    
}
