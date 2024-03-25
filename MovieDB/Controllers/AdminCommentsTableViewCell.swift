import UIKit
import RealmSwift

class AdminCommentsTableViewCell: UITableViewCell {
    
    let loginLabel = UILabel()
    let filmNameLabel = UILabel()
    let filmNameText = UILabel()
    let descriptionLabel = UILabel()
    let userLabel = UILabel()
    let commentLabel = UILabel()
    let markLabel = UILabel()
    
    let raitingStackView = UIStackView()
    let firstStar = UIView()
    let secondStar = UIView()
    let thirdStar = UIView()
    let fourghtStar = UIView()
    let fivethStar = UIView()
    
    let firstStarImageView = UIImageView()
    let secondStarImageView = UIImageView()
    let thirdStarImageView = UIImageView()
    let fourghtStarImageView = UIImageView()
    let fivethStarImageView = UIImageView()
   
    let filllStarImage = UIImage(systemName: "star.fill")
    let starImage = UIImage(systemName: "star")
    let starTintColor = UIColor(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
    
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
    private func defaultConfigStars() {
        [firstStarImageView, secondStarImageView, thirdStarImageView, fourghtStarImageView, fivethStarImageView].forEach {
            $0.image = starImage
            $0.tintColor = starTintColor
        }
        firstStar.addSubview(firstStarImageView)
        setConstraintsForStar(star: firstStar, starView: firstStarImageView)
        secondStar.addSubview(secondStarImageView)
        setConstraintsForStar(star: secondStar, starView: secondStarImageView)
        thirdStar.addSubview(thirdStarImageView)
        setConstraintsForStar(star: thirdStar, starView: thirdStarImageView)
        fourghtStar.addSubview(fourghtStarImageView)
        setConstraintsForStar(star: fourghtStar, starView: fourghtStarImageView)
        fivethStar.addSubview(fivethStarImageView)
        setConstraintsForStar(star: fivethStar, starView: fivethStarImageView)
    }
    
    private func configStackView() {
        raitingStackView.distribution = .equalSpacing
    }
    
    private func setConstraintsForStar(star: UIView, starView: UIImageView) {
        star.translatesAutoresizingMaskIntoConstraints = false
        starView.translatesAutoresizingMaskIntoConstraints = false
        star.widthAnchor.constraint(equalToConstant: 20).isActive = true
        NSLayoutConstraint.activate([
            starView.topAnchor.constraint(equalTo: star.topAnchor),
            starView.leadingAnchor.constraint(equalTo: star.leadingAnchor),
            starView.trailingAnchor.constraint(equalTo: star.trailingAnchor),
            starView.bottomAnchor.constraint(equalTo: star.bottomAnchor)
        ])
    }
    
    public func configCell(comment: Comments, adminVC: AdminVC) {
        self.adminVC = adminVC
        self.comment = comment
        addSubViews()
        setConstraints()
        [approvedButton, rejectButton, bannedButton].forEach {
            $0.layer.cornerRadius = 12
        }
        addTargetsForElements()
        visualConfig(user: comment.userName, comment: comment.text, mark: comment.mark, filmname: comment.filmName)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleFilmNameTextTap))
        filmNameText.isUserInteractionEnabled = true
        filmNameText.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(handleCommentLabelTap))
        commentLabel.isUserInteractionEnabled = true
        commentLabel.addGestureRecognizer(tapGesture1)
    }
    
    private func addSubViews() {
        self.addSubview(userLabel)
        self.addSubview(loginLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(commentLabel)
        self.addSubview(raitingStackView)
        self.addSubview(approvedButton)
        self.addSubview(rejectButton)
        self.addSubview(bannedButton)
        self.addSubview(filmNameText)
        self.addSubview(filmNameLabel)
        self.addSubview(markLabel)
    }

    private func setConstraints() {
        [loginLabel, userLabel, filmNameText, filmNameLabel, descriptionLabel, commentLabel,markLabel, raitingStackView, approvedButton, rejectButton, bannedButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        // 184 + 70 = 254
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            loginLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            loginLabel.heightAnchor.constraint(equalToConstant: 22),
            loginLabel.widthAnchor.constraint(equalToConstant: 108)
        ])
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            userLabel.leadingAnchor.constraint(equalTo: loginLabel.trailingAnchor, constant: 4),
            userLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            userLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        NSLayoutConstraint.activate([
            filmNameLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 8),
            filmNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            filmNameLabel.heightAnchor.constraint(equalToConstant: 22),
            filmNameLabel.widthAnchor.constraint(equalToConstant: 108)
        ])
        NSLayoutConstraint.activate([
            filmNameText.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 8),
            filmNameText.leadingAnchor.constraint(equalTo: filmNameLabel.trailingAnchor, constant: 4),
            filmNameText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            filmNameText.heightAnchor.constraint(equalToConstant: 22)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: filmNameText.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 22),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 112)
        ])
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            commentLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            commentLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            markLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 8),
            markLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            markLabel.heightAnchor.constraint(equalToConstant: 22),
            markLabel.widthAnchor.constraint(equalToConstant: 108)
        ])
        NSLayoutConstraint.activate([
            raitingStackView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            raitingStackView.topAnchor.constraint(equalTo: markLabel.bottomAnchor, constant: 8),
            raitingStackView.heightAnchor.constraint(equalToConstant: 20),
            raitingStackView.widthAnchor.constraint(equalToConstant: 116)
        ])
        NSLayoutConstraint.activate([
            approvedButton.topAnchor.constraint(equalTo: raitingStackView.bottomAnchor, constant: 10),
            approvedButton.leadingAnchor.constraint(equalTo: commentLabel.leadingAnchor),
            approvedButton.widthAnchor.constraint(equalToConstant: 90),
            approvedButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            rejectButton.topAnchor.constraint(equalTo: raitingStackView.bottomAnchor, constant: 10),
            rejectButton.leadingAnchor.constraint(equalTo: approvedButton.trailingAnchor,constant: 34),
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

    @objc private func handleFilmNameTextTap() {
        let alertController = UIAlertController(title: "Movie Title", message: comment.filmName, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        adminVC.present(alertController, animated: true, completion: nil)
    }

    @objc private func handleCommentLabelTap() {
        let alertController = UIAlertController(title: "Description", message: comment.text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        adminVC.present(alertController, animated: true, completion: nil)
    }
    
    private func visualConfig(user: String, comment: String, mark: Int, filmname: String) {
        self.backgroundColor = .darkBlue
        loginLabel.text = "User Name:"
        loginLabel.textColor = .white
        loginLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        userLabel.text = user
        descriptionLabel.text = "Description:"
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        filmNameLabel.text = "Movie title:"
        filmNameLabel.textColor = .white
        filmNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        commentLabel.text = comment
        filmNameText.text = filmname
        filmNameText.textColor = .white
        markLabel.text = "Rating:"
        markLabel.textColor = .white
        markLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        self.selectionStyle = .none
        userLabel.textColor = .white
        commentLabel.textColor = .white
        commentLabel.numberOfLines = 0
        
        defaultConfigStars()
        configStackView()
        [firstStar, secondStar, thirdStar, fourghtStar, fivethStar].forEach {
            raitingStackView.addArrangedSubview($0)
        }
        approvedButton.backgroundColor = .greenColor
        bannedButton.backgroundColor = .backgroundColorLaunchScreen
        rejectButton.backgroundColor = .darkGray
        [approvedButton, bannedButton,rejectButton].forEach {
            $0.setTitleColor(.white, for: .normal)
        }
        approvedButton.setTitle("Approved", for: .normal)
        bannedButton.setTitle("Banned", for: .normal)
        rejectButton.setTitle("Reject", for: .normal)
        
        switch mark {
        case 0:
            firstStarImageView.image = starImage
            secondStarImageView.image = starImage
            thirdStarImageView.image = starImage
            fourghtStarImageView.image = starImage
            fivethStarImageView.image = starImage
        case 2:
            firstStarImageView.image = filllStarImage
            secondStarImageView.image = starImage
            thirdStarImageView.image = starImage
            fourghtStarImageView.image = starImage
            fivethStarImageView.image = starImage
        case 4:
            firstStarImageView.image = filllStarImage
            secondStarImageView.image = filllStarImage
            thirdStarImageView.image = starImage
            fourghtStarImageView.image = starImage
            fivethStarImageView.image = starImage
        case 6:
            firstStarImageView.image = filllStarImage
            secondStarImageView.image = filllStarImage
            thirdStarImageView.image = filllStarImage
            fourghtStarImageView.image = starImage
            fivethStarImageView.image = starImage
        case 8:
            firstStarImageView.image = filllStarImage
            secondStarImageView.image = filllStarImage
            thirdStarImageView.image = filllStarImage
            fourghtStarImageView.image = filllStarImage
            fivethStarImageView.image = starImage
        case 10:
            firstStarImageView.image = filllStarImage
            secondStarImageView.image = filllStarImage
            thirdStarImageView.image = filllStarImage
            fourghtStarImageView.image = filllStarImage
            fivethStarImageView.image = filllStarImage
        default:
            return
        }
        self.selectionStyle = .none
    }
    
    private func addTargetsForElements() {
        approvedButton.addTarget(self, action: #selector(approvedButtonIsPressed), for: .touchUpInside)
        bannedButton.addTarget(self, action: #selector(bannedButtonIsPressed), for: .touchUpInside)
        rejectButton.addTarget(self, action: #selector(rejectButtonIsPressed), for: .touchUpInside)
        
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
    @objc private func rejectButtonIsPressed(_ sender: UIButton) {
        let realm = try! Realm()
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
