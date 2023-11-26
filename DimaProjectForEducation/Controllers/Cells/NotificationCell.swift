import UIKit

class NotificationCell: UITableViewCell {
    
    let filmNameLabel = UILabel()
    let commentTextLabel = UILabel()
    let commentDateLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setConstraints() {
        filmNameLabel.translatesAutoresizingMaskIntoConstraints = false
        commentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        commentDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filmNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            filmNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            filmNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            commentTextLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 8),
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
    }
    
    public func configCell(comment: Comments) {
        addSubviews()
        setConstraints()
        filmNameLabel.text = comment.filmName
        commentTextLabel.text = comment.text
        commentTextLabel.numberOfLines = 0
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm"
        commentDateLabel.text = dateFormater.string(from: comment.date)
        switch comment.status {
        case 0:
            self.backgroundColor = .gray
        case 1:
            self.backgroundColor = .greenColor
        case -1:
            self.backgroundColor = .backgroundColorLaunchScreen
        default:
            break
        }
        self.selectionStyle = .none
    }

}
