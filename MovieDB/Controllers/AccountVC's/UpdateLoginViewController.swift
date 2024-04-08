import UIKit
import RealmSwift

class UpdateLoginViewController: UIViewController {
    let avatarImage = UIImageView()
    let changeImageButton = UIButton()
    let dropImageButton = UIButton()
    let userTextLabel = UILabel()
    let userNameField = UITextField()
    private let usernameIcon: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: "UserIcon") {
            imageView.image = image
        }
        return imageView
    }()
    let changePasswordButton = UIButton()
    let saveChangeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkBlue
        self.setTitleNavBar(text: "Account Information")
        addSubViews()
        setConstraions()
        setConfigOfAccess()
        configAvatarImage()
        configUsernameField()
        configChangeImageButton()
        configDropImageButton()
        configLabels()
        configSaveChangeButton()
        configChangePasswordButton()
        addTargetsForElements()
    }
    
    private func addTargetsForElements() {
        changeImageButton.addTarget(self, action: #selector(changeImageButtonIsPressed), for: .touchUpInside)
    }
    
    private func addSubViews() {
        [avatarImage,changeImageButton,userTextLabel,userNameField,usernameIcon,changePasswordButton,saveChangeButton,dropImageButton].forEach {
            self.view.addSubview($0)
        }
    }
    
    private func setConstraions(){
        [avatarImage,changeImageButton,userTextLabel,userNameField,usernameIcon,changePasswordButton,saveChangeButton,dropImageButton].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            avatarImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            avatarImage.heightAnchor.constraint(equalToConstant: 90),
            avatarImage.widthAnchor.constraint(equalToConstant: 90)
        ])
        NSLayoutConstraint.activate([
            changeImageButton.topAnchor.constraint(equalTo: self.avatarImage.bottomAnchor, constant: 15),
            changeImageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            changeImageButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            dropImageButton.topAnchor.constraint(equalTo: self.changeImageButton.bottomAnchor, constant: 15),
            dropImageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dropImageButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            userTextLabel.bottomAnchor.constraint(equalTo: userNameField.topAnchor),
            userTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            userTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            userTextLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            userNameField.topAnchor.constraint(equalTo: self.changeImageButton.bottomAnchor, constant: 120),
            userNameField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            userNameField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            userNameField.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            usernameIcon.centerYAnchor.constraint(equalTo: userNameField.centerYAnchor),
            usernameIcon.leadingAnchor.constraint(equalTo: userNameField.leadingAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            changePasswordButton.bottomAnchor.constraint(equalTo: self.saveChangeButton.topAnchor,constant: -25),
            changePasswordButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            saveChangeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
            saveChangeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            saveChangeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            saveChangeButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
    }
    private func configUsernameField() {
        userNameField.delegate = self
        userNameField.textColor = .white
        let paddingInField: CGFloat = 10
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingInField, height: userNameField.bounds.height))
        userNameField.leftView = paddingView
        userNameField.leftViewMode = .always
        userNameField.layer.borderColor = UIColor.defaultBorderColor
        userNameField.layer.borderWidth = 1.0
        userNameField.backgroundColor = .blueGray
        userNameField.textColor = .white
        userNameField.layer.cornerRadius = 5
    }
    private func configLabels(){
        [userTextLabel].forEach{
            $0.font = UIFont(name: "Montserrat-Medium", size: 16)
            $0.textColor = .lightGray
        }
        userTextLabel.text = "USER NAME"
    }
    private func configAvatarImage(){
        avatarImage.tintColor = .white
        avatarImage.layer.cornerRadius = 45
        avatarImage.backgroundColor = .black
        avatarImage.clipsToBounds = true
    }
    
    private func configChangeImageButton(){
        changeImageButton.setTitle("Change Photo", for: .normal)
        changeImageButton.setTitleColor(.changeImageColor, for: .normal)
        changeImageButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 16)
    }
    private func configDropImageButton(){
        dropImageButton.setTitle("Drop Photo", for: .normal)
        dropImageButton.setTitleColor(.crimson, for: .normal)
        dropImageButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 16)
        dropImageButton.addTarget(self, action: #selector(dropImageButtonIsPressed), for: .touchUpInside)
    }
    private func configChangePasswordButton(){
        changePasswordButton.setTitle("Change Password", for: .normal)
        changePasswordButton.setTitleColor(.crimson, for: .normal)
        changePasswordButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 20)
        
        changePasswordButton.addTarget(self, action: #selector(changePasswordIsPressed), for: .touchUpInside)
    }
    
    private func configSaveChangeButton() {
        saveChangeButton.setTitle("Save Change", for: .normal)
        saveChangeButton.layer.cornerRadius = 5
        saveChangeButton.backgroundColor = .crimson
        saveChangeButton.setTitleColor(.white, for: .normal)
        saveChangeButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        
        saveChangeButton.addTarget(self, action: #selector(saveChangeButtonIsPressed), for: .touchUpInside)
    }
    
    private func setConfigOfAccess(){
        if LoginUser.shared.user?.isAdmin ?? false {
            avatarImage.image = UIImage(data: LoginUser.shared.user?.avatarImageData ?? Data()) ?? UIImage(systemName: "person.badge.key")
        }
        else {
            avatarImage.image = UIImage(data: LoginUser.shared.user?.avatarImageData ?? Data()) ?? UIImage(systemName: "person.circle.fill")
        }
    }
    @objc private func dropImageButtonIsPressed(_ sender: UIButton) {
        let realm = try! Realm()

        guard let currentUser = realm.objects(User.self).filter("username == %@", LoginUser.shared.user?.username ?? "").first else {
            return
        }

        if currentUser.isAdmin {
               try! realm.write {
                   currentUser.avatarImageData = UIImage(systemName: "person.badge.key")?.jpegData(compressionQuality: 1) ?? Data()
               }
           } else {
               try! realm.write {
                   currentUser.avatarImageData = UIImage(systemName: "person.circle.fill")?.jpegData(compressionQuality: 1) ?? Data()
               }
           }
        avatarImage.image = UIImage(data: currentUser.avatarImageData)
    }


    @objc private func saveChangeButtonIsPressed(_ sender: UIButton) {
        guard let newUsername = userNameField.text, !newUsername.isEmpty else {
            return
        }
        
        let realm = try! Realm()
        
        let usernameExists = realm.objects(User.self).filter("username == %@", newUsername).count > 0
        
        if usernameExists {
            let alertController = UIAlertController(title: "Error",
                                                    message: "Username already exists. Please choose a different username.",
                                                    preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            self.userNameField.text = ""
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        let messages = realm.objects(ChatMessage.self).filter("user == %@", LoginUser.shared.user?.username ?? "")
        
        for message in messages {
            try! realm.write {
                message.user = newUsername
            }
        }
        let comments = realm.objects(Comments.self).filter("userName == %@", LoginUser.shared.user?.username ?? "")
        for comment in comments {
            try! realm.write {
                comment.userName = newUsername
            }
        }
        if let currentUser = realm.objects(User.self).filter("username == %@", LoginUser.shared.user?.username ?? "").first {
            try! realm.write {
                currentUser.username = newUsername
            }
            
            let alertController = UIAlertController(title: "Successfully",
                                                    message: "Changes saved",
                                                    preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.userNameField.text = ""
            }
            
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        }
    }

    @objc private func handleSwipeBack(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .recognized {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc private func changePasswordIsPressed(_ gesture: UITapGestureRecognizer) {
        navigationController?.show(ChangePasswordViewController(), sender: nil)
    }
    
    @objc private func changeImageButtonIsPressed(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
}
extension UpdateLoginViewController: UITextFieldDelegate {
    /// Приховує іконку поля коли користувач починає взаємодію з полем
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.selectedBorderColor
        
        switch textField {
        case userNameField:
            usernameIcon.isHidden = true
        default:
            break;
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Приховати клавіатуру
        return true
    }
    /// Приховує іконку поля коли користувач закінчів взаємодію з полем
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.defaultBorderColor
        guard textField.text?.isEmpty ?? true else { return }
        
        switch textField {
        case userNameField:
            usernameIcon.isHidden = false
        default:
            break;
        }
    }
}

extension UpdateLoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] is UIImage {
            if let selectedImage = info[.originalImage] as? UIImage {
                let realm = try! Realm()
                guard let currentUser = realm.objects(User.self).filter("username == %@", LoginUser.shared.user?.username ?? "").first else {
                    return
                }
                try! realm.write {
                    currentUser.avatarImageData = selectedImage.jpegData(compressionQuality: 1) ?? Data()
                }
                avatarImage.image = selectedImage
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
