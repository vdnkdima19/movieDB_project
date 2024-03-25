import UIKit
import RealmSwift

class AdminVC: UIViewController {
    
    let commentsTableView = UITableView()
    let adminLabel = UILabel()
    var commentsArr: [Comments] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleNavBar(text: "Administration")
        addSubViews()
        configChildElements()
        setConstraints()
        let realm = try! Realm()
        let comments = realm.objects(Comments.self).where({
            $0.status == 0
        })
        comments.forEach {
            commentsArr.append($0)
        }
    }
    
    
    
    private func addSubViews() {
        self.view.addSubview(adminLabel)
        self.view.addSubview(commentsTableView)
    }
    
    private func configChildElements() {
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        
        commentsTableView.backgroundColor = .darkBlue
        
        commentsTableView.register(AdminCommentsTableViewCell.self, forCellReuseIdentifier: "AdminCommentsTableViewCell")
    }
    
    private func setConstraints() {
        adminLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            adminLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            adminLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90)
        ])
        NSLayoutConstraint.activate([
            commentsTableView.topAnchor.constraint(equalTo: adminLabel.bottomAnchor, constant: 30),
            commentsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            commentsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            commentsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30)
        ])
    }
}

extension AdminVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionCastomView = UIView()
        let sectionNameLabel = UILabel(frame: CGRect(x: 16, y: 0,width: Int(tableView.frame.width - 16), height: 30))
        sectionCastomView.addSubview(sectionNameLabel)
        sectionCastomView.backgroundColor = .darkBlue
        sectionNameLabel.text = "NEW COMMENTS"
        sectionNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        sectionNameLabel.textAlignment = .left
        sectionNameLabel.textColor = .white
        return sectionCastomView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AdminCommentsTableViewCell", for: indexPath) as? AdminCommentsTableViewCell {
            cell.configCell(comment: commentsArr[indexPath.row], adminVC: self)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        168
    }
}
