import UIKit

class MessageTableViewCell: UITableViewCell {
    let messageView = UIView()
    let textMessage = UILabel()
    let timeWriting = UILabel()
    let avatarImageView = UIImageView()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configCell(message: String, date: String, avatarImage: UIImage) {
        self.selectionStyle = .none
        
        self.addSubview(messageView)
        self.addSubview(timeWriting)
        self.addSubview(avatarImageView)
        messageView.addSubview(textMessage)
        
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 24
        avatarImageView.image = avatarImage
        
        messageView.layer.cornerRadius = 8
        messageView.backgroundColor = .yellow
        
        textMessage.numberOfLines = 0
        textMessage.text = message
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm"
        
        timeWriting.text = date
        timeWriting.textAlignment = .left
        
        messageView.translatesAutoresizingMaskIntoConstraints = false
        textMessage.translatesAutoresizingMaskIntoConstraints = false
        timeWriting.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            messageView.bottomAnchor.constraint(equalTo: textMessage.bottomAnchor, constant: 12),
            messageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 4),
            messageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -90)
        ])
        NSLayoutConstraint.activate([
            textMessage.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 12),
            textMessage.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 12),
            textMessage.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -12)
        ])
        NSLayoutConstraint.activate([
            timeWriting.topAnchor.constraint(equalTo: messageView.bottomAnchor,constant: 8),
            timeWriting.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            timeWriting.trailingAnchor.constraint(equalTo: messageView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            avatarImageView.bottomAnchor.constraint(equalTo: timeWriting.topAnchor, constant: -8),
            avatarImageView.leadingAnchor.constraint(equalTo: timeWriting.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 48),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1)
        ])
        
        self.bottomAnchor.constraint(equalTo: timeWriting.bottomAnchor, constant: 8).isActive = true
    }
}
