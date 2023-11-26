import UIKit
import RealmSwift

class AdminCommentsTableViewCell: UITableViewCell {
    
    let userLabel = UILabel()
    let commentLabel = UILabel()
    let approvedButton = UIButton()
    let rejectButton = UIButton()
    let bannedButton = UIButton()
    var comment: Comments!
    var adminVC: AdminVC!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    public func configCell(comment: Comments, adminVC: AdminVC) {
        self.adminVC = adminVC
        self.comment = comment
        addSubViews()
        setConstraints()
        addTargetsForElements()
        visualConfig(user: comment.userName, comment: comment.text)
    }
    
    private func addSubViews() {
        self.addSubview(userLabel)
        self.addSubview(commentLabel)
        self.addSubview(approvedButton)
        self.addSubview(rejectButton)
        self.addSubview(bannedButton)
    }

    private func setConstraints() {
        [userLabel, commentLabel, approvedButton, rejectButton, bannedButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        // 8 + 16 + 8 + 52 + 8 + 30 + 8 + 30 + 8 = 168
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            userLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            userLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            userLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 8),
            commentLabel.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: userLabel.trailingAnchor),
            commentLabel.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            approvedButton.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 8),
            approvedButton.leadingAnchor.constraint(equalTo: commentLabel.leadingAnchor),
            approvedButton.widthAnchor.constraint(equalToConstant: 90),
            approvedButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            rejectButton.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 8),
            rejectButton.leadingAnchor.constraint(equalTo: approvedButton.trailingAnchor,constant: 22),
            rejectButton.widthAnchor.constraint(equalToConstant: 90),
            rejectButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            bannedButton.topAnchor.constraint(equalTo: approvedButton.topAnchor),
            bannedButton.bottomAnchor.constraint(equalTo: approvedButton.bottomAnchor),
            bannedButton.trailingAnchor.constraint(equalTo: userLabel.trailingAnchor),
            bannedButton.widthAnchor.constraint(equalTo: approvedButton.widthAnchor, multiplier: 1)
        ])
    }
    
    private func visualConfig(user: String, comment: String) {
        self.backgroundColor = .darkBlue
        userLabel.text = user
        commentLabel.text = comment
        self.selectionStyle = .none
        userLabel.textColor = .white
        commentLabel.textColor = .white
        
        approvedButton.backgroundColor = .green
        bannedButton.backgroundColor = .backgroundColorLaunchScreen
        rejectButton.backgroundColor = .darkGray
        [approvedButton, bannedButton,rejectButton].forEach {
            $0.setTitleColor(.white, for: .normal)
        }
        approvedButton.setTitle("Approved", for: .normal)
        bannedButton.setTitle("Banned", for: .normal)
        rejectButton.setTitle("Reject", for: .normal)
    }
    
    private func addTargetsForElements() {
        approvedButton.addTarget(self, action: #selector(approvedButtonIsPressed), for: .touchUpInside)
        bannedButton.addTarget(self, action: #selector(bannedButtonIsPressed), for: .touchUpInside)
    }
    
    @objc private func approvedButtonIsPressed(_ sender: UIButton) {
        let realm = try! Realm()

        let findedComment = realm.objects(Comments.self).first(where: {
            $0.id == self.comment.id
        })
        try! realm.write {
            findedComment?.status = 1
        }
        
        let comments = realm.objects(Comments.self).where({
            $0.status == 0
        })
        adminVC.commentsArr = []
        comments.forEach {
            adminVC.commentsArr.append($0)
        }
        adminVC.commentsTableView.reloadData()
    }
    @objc private func bannedButtonIsPressed(_ sender: UIButton) {
        let realm = try! Realm()

        let findUser = realm.objects(User.self).first(where: {
            $0.username == comment.userName
        })
        
        if !(findUser?.isAdmin ?? true) {
            try! realm.write {
                findUser?.isBanned = true
            }
            let findedComment = realm.objects(Comments.self).first(where: {
                $0.id == self.comment.id
            })
            try! realm.write {
                findedComment?.status = -1
            }
            
            let comments = realm.objects(Comments.self).where({
                $0.status == 0
            })
            adminVC.commentsArr = []
            comments.forEach {
                adminVC.commentsArr.append($0)
            }
            adminVC.commentsTableView.reloadData()
        }
        
    }
    
}
