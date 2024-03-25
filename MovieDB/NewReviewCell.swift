import UIKit
import RealmSwift

class NewReviewCell: UITableViewCell {
    
    let commentTextField = UITextField()
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
    
    let firstStarTap = UITapGestureRecognizer()
    let secondStarTap = UITapGestureRecognizer()
    let thirdStarTap = UITapGestureRecognizer()
    let fourghtStarTap = UITapGestureRecognizer()
    let fivethStarTap = UITapGestureRecognizer()
    
    var mark: Int = 0
    var commentStr: String = ""
    var filmName: String = ""
    
    let sendButton = UIButton()
    
    // 30 + 4 + 30 + 4 + 30 + 4 + 30 + 4 + 30
    
    let filllStarImage = UIImage(systemName: "star.fill")
    let starImage = UIImage(systemName: "star")
    let starTintColor = UIColor(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
    let cellBackgroundColor = UIColor(#colorLiteral(red: 0.1685389876, green: 0.2090523839, blue: 0.2594455481, alpha: 1))
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configCell(filmName: String) {
        self.filmName = filmName
        self.addSubview(commentTextField)
        self.addSubview(raitingStackView)
        self.addSubview(sendButton)
        [firstStar, secondStar, thirdStar, fourghtStar, fivethStar].forEach {
            raitingStackView.addArrangedSubview($0)
        }
        setConstraints()
        configStackView()
        defaultConfigStars()
        
        commentTextField.leftViewMode = .always
        commentTextField.layer.borderColor = UIColor.defaultBorderColor
        commentTextField.layer.borderWidth = 1.0
        commentTextField.backgroundColor = .darkBlue
        commentTextField.textColor = .white
        commentTextField.layer.cornerRadius = 5
        
        commentTextField.placeholder = "your comment"
        
        self.backgroundColor = cellBackgroundColor
        setTargetsForStars()
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        sendButton.layer.cornerRadius = 5
        sendButton.backgroundColor = .crimson
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        sendButton.setTitle("Send", for: .normal)
        self.selectionStyle = .none
        
        commentTextField.delegate = self
    }
    
    private func defaultConfigStars() {
        [firstStarImageView, secondStarImageView, thirdStarImageView, fourghtStarImageView, fivethStarImageView].forEach {
            $0.image = starImage
            $0.tintColor = starTintColor
        }
        firstStar.addSubview(firstStarImageView)
        setConstraintsForStar(star: firstStar, starView: firstStarImageView)
        firstStar.addGestureRecognizer(firstStarTap)
        secondStar.addSubview(secondStarImageView)
        setConstraintsForStar(star: secondStar, starView: secondStarImageView)
        secondStar.addGestureRecognizer(secondStarTap)
        thirdStar.addSubview(thirdStarImageView)
        setConstraintsForStar(star: thirdStar, starView: thirdStarImageView)
        thirdStar.addGestureRecognizer(thirdStarTap)
        fourghtStar.addSubview(fourghtStarImageView)
        setConstraintsForStar(star: fourghtStar, starView: fourghtStarImageView)
        fourghtStar.addGestureRecognizer(fourghtStarTap)
        fivethStar.addSubview(fivethStarImageView)
        setConstraintsForStar(star: fivethStar, starView: fivethStarImageView)
        fivethStar.addGestureRecognizer(fivethStarTap)
    }
    
    private func configStackView() {
        raitingStackView.distribution = .equalSpacing
        
    }
    
    private func setConstraintsForStar(star: UIView, starView: UIImageView) {
        star.translatesAutoresizingMaskIntoConstraints = false
        starView.translatesAutoresizingMaskIntoConstraints = false
        star.widthAnchor.constraint(equalToConstant: 30).isActive = true
        NSLayoutConstraint.activate([
            starView.topAnchor.constraint(equalTo: star.topAnchor),
            starView.leadingAnchor.constraint(equalTo: star.leadingAnchor),
            starView.trailingAnchor.constraint(equalTo: star.trailingAnchor),
            starView.bottomAnchor.constraint(equalTo: star.bottomAnchor)
        ])
    }
    
    private func setConstraints() {
        [commentTextField, raitingStackView, sendButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            raitingStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            raitingStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            raitingStackView.widthAnchor.constraint(equalToConstant: 166),
            raitingStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            commentTextField.topAnchor.constraint(equalTo: raitingStackView.bottomAnchor, constant: 16),
            commentTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            commentTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            commentTextField.heightAnchor.constraint(equalToConstant: 42)
        ])
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: commentTextField.bottomAnchor, constant: 16),
            sendButton.leadingAnchor.constraint(equalTo: commentTextField.leadingAnchor),
            sendButton.trailingAnchor.constraint(equalTo: commentTextField.trailingAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    private func setTargetsForStars() {
        [firstStarTap, secondStarTap, thirdStarTap, fourghtStarTap, fivethStarTap].forEach {
            $0.addTarget(self, action: #selector(starIsTapped))
        }
    }
    
    @objc private func sendButtonTapped(_ sender: UIButton) {
        if !commentTextField.text!.isEmpty {
            let realm = try! Realm()
            
            textFieldDidEndEditing(commentTextField)
            
            let newComment = Comments()
            newComment.text = commentStr
            newComment.userName = LoginUser.shared.user?.username ?? ""
            newComment.filmId = SellectedMoview.moview?.id ?? 0
            newComment.mark = mark
            newComment.id = realm.objects(Comments.self).count
            newComment.filmName = self.filmName
            // Збереження об'єкту User в Realm
            try! realm.write {
                realm.add(newComment)
            }
            
            // Show alert
            let alertController = UIAlertController(title: "Review Submitted",
                                                    message: "Thank you for your review!",
                                                    preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.commentTextField.text = ""
                self?.commentStr = ""
                self?.defaultConfigStars()
            }
            
            alertController.addAction(okayAction)
            
            // Present the alert controller
            if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                viewController.present(alertController, animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "Review is empty", message: "", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.defaultConfigStars()
            }
            alertController.addAction(okayAction)
            
            if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func starIsTapped(_ sender: UITapGestureRecognizer) {
        switch sender {
        case firstStarTap: do {
            firstStarImageView.image = filllStarImage
            secondStarImageView.image = starImage
            thirdStarImageView.image = starImage
            fourghtStarImageView.image = starImage
            fivethStarImageView.image = starImage
            mark = 2
        }
        case secondStarTap: do {
            firstStarImageView.image = filllStarImage
            secondStarImageView.image = filllStarImage
            thirdStarImageView.image = starImage
            fourghtStarImageView.image = starImage
            fivethStarImageView.image = starImage
            mark = 4
        }
        case thirdStarTap: do {
            firstStarImageView.image = filllStarImage
            secondStarImageView.image = filllStarImage
            thirdStarImageView.image = filllStarImage
            fourghtStarImageView.image = starImage
            fivethStarImageView.image = starImage
            mark = 6
        }
        case fourghtStarTap: do {
            firstStarImageView.image = filllStarImage
            secondStarImageView.image = filllStarImage
            thirdStarImageView.image = filllStarImage
            fourghtStarImageView.image = filllStarImage
            fivethStarImageView.image = starImage
            mark = 8
        }
        case fivethStarTap: do {
            firstStarImageView.image = filllStarImage
            secondStarImageView.image = filllStarImage
            thirdStarImageView.image = filllStarImage
            fourghtStarImageView.image = filllStarImage
            fivethStarImageView.image = filllStarImage
            mark = 10
        }
        default:
            return
        }
    }
}

extension NewReviewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        commentStr = textField.text ?? ""
    }
}
