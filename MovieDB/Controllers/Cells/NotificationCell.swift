import UIKit

class NotificationCell: UITableViewCell {
    
    let filmNameLabel = UILabel()
    let commentTextLabel = UILabel()
    let commentDateLabel = UILabel()
    let imageOfRewiews = UIImageView()
    let starsStackView = UIStackView()
    
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
    
    private func setConstraints() {
        filmNameLabel.translatesAutoresizingMaskIntoConstraints = false
        commentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        commentDateLabel.translatesAutoresizingMaskIntoConstraints = false
        imageOfRewiews.translatesAutoresizingMaskIntoConstraints = false
        raitingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageOfRewiews.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageOfRewiews.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageOfRewiews.widthAnchor.constraint(equalToConstant: 40),
            imageOfRewiews.heightAnchor.constraint(equalToConstant: 40),
        ])
        NSLayoutConstraint.activate([
            filmNameLabel.leadingAnchor.constraint(equalTo: imageOfRewiews.trailingAnchor, constant: 16),
            filmNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            filmNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            raitingStackView.leadingAnchor.constraint(equalTo: imageOfRewiews.trailingAnchor, constant: 16),
            raitingStackView.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 8),
            raitingStackView.heightAnchor.constraint(equalToConstant: 20),
            raitingStackView.widthAnchor.constraint(equalToConstant: 116)
        ])
        NSLayoutConstraint.activate([
            commentTextLabel.topAnchor.constraint(equalTo: raitingStackView.bottomAnchor, constant: 8),
            commentTextLabel.leadingAnchor.constraint(equalTo: filmNameLabel.leadingAnchor),
            commentTextLabel.trailingAnchor.constraint(equalTo: filmNameLabel.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            commentDateLabel.topAnchor.constraint(equalTo: commentTextLabel.bottomAnchor, constant: 8),
            commentDateLabel.leadingAnchor.constraint(equalTo: filmNameLabel.leadingAnchor),
            commentDateLabel.trailingAnchor.constraint(equalTo: filmNameLabel.trailingAnchor)
        ])
        self.bottomAnchor.constraint(equalTo: commentDateLabel.bottomAnchor, constant: 8).isActive = true
    }
    private func addSubviews() {
        self.addSubview(filmNameLabel)
        self.addSubview(commentTextLabel)
        self.addSubview(commentDateLabel)
        self.addSubview(imageOfRewiews)
        self.addSubview(raitingStackView)
    }
    public func configCell(comment: Comments) {
        addSubviews()
        setConstraints()
        defaultConfigStars()
        configStackView()
        [firstStar, secondStar, thirdStar, fourghtStar, fivethStar].forEach {
            raitingStackView.addArrangedSubview($0)
        }
        self.backgroundColor = .darkBlue
        [filmNameLabel,commentTextLabel,commentDateLabel].forEach {
            $0.textColor = .white
        }
        filmNameLabel.text = comment.filmName
        
        commentTextLabel.text = comment.text
        commentTextLabel.numberOfLines = 0
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm"
        commentDateLabel.text = dateFormater.string(from: comment.date)
        switch comment.status {
        case 0:
            self.backgroundColor = .gray
        case 1:
            imageOfRewiews.image = UIImage(systemName: "hand.thumbsup.circle")
            imageOfRewiews.tintColor = UIColor.greenColor
        case -1:
            imageOfRewiews.image = UIImage(systemName: "hand.thumbsdown.circle")
            imageOfRewiews.tintColor = UIColor.backgroundColorLaunchScreen
        default:
            break
        }
        switch comment.mark {
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

}
