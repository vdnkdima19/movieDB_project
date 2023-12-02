import UIKit

class CurrentUserMessageTableViewCell: UITableViewCell {
    let messageView = UIView()
    let textMessage = UILabel()
    let timeWriting = UILabel()
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    public func configCell(message: String, date: String) {
        self.addSubview(messageView)
        self.addSubview(timeWriting)
        messageView.addSubview(textMessage)
        messageView.layer.cornerRadius = 8
        messageView.backgroundColor = .blue
        messageView.translatesAutoresizingMaskIntoConstraints = false
        textMessage.translatesAutoresizingMaskIntoConstraints = false
        timeWriting.translatesAutoresizingMaskIntoConstraints = false
        textMessage.numberOfLines = 0
        textMessage.text = message
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm"
        timeWriting.text = date
        self.selectionStyle = .none
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            textMessage.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 12),
            textMessage.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 12),
            textMessage.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -12),
            messageView.bottomAnchor.constraint(equalTo: textMessage.bottomAnchor, constant: 12),
            messageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 90),
            messageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            messageView.heightAnchor.constraint(equalToConstant: 50),
            self.bottomAnchor.constraint(equalTo: timeWriting.bottomAnchor, constant: 8)
        ])
        NSLayoutConstraint.activate([
            timeWriting.topAnchor.constraint(equalTo: messageView.bottomAnchor,constant: 8),
            timeWriting.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }

}
