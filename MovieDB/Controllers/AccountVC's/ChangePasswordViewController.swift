import UIKit
import RealmSwift

class ChangePasswordViewController: UIViewController {
    let oldPasswordLabel = UILabel()
    let oldPasswordField = UITextField()
    let newPasswordLabel = UILabel()
    let newPasswordField = UITextField()
    let reTypePasswordLabel = UILabel()
    let reTypePasswordField = UITextField()
    let passwordFieldIcon = UIImageView()
    let passwordFieldIcon1 = UIImageView()
    let passwordFieldIcon2 = UIImageView()
    let saveChangeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkBlue
        self.setTitleNavBar(text: "Change Password")
        addSubViews()
        setConstraions()
        configTextField()
        configImage()
        configLabels()
        configSaveChangeButton()
    }
    private func addSubViews() {
        [oldPasswordField,newPasswordField,reTypePasswordField,passwordFieldIcon,passwordFieldIcon1,passwordFieldIcon2,oldPasswordLabel,newPasswordLabel,reTypePasswordLabel,saveChangeButton].forEach {
            self.view.addSubview($0)
        }
    }
    private func setConstraions(){
        [oldPasswordField,newPasswordField,reTypePasswordField,passwordFieldIcon,passwordFieldIcon,passwordFieldIcon1,passwordFieldIcon2,oldPasswordLabel,newPasswordLabel,reTypePasswordLabel,saveChangeButton].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            oldPasswordLabel.bottomAnchor.constraint(equalTo: oldPasswordField.topAnchor),
            oldPasswordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            oldPasswordLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            oldPasswordLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            oldPasswordField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160),
            oldPasswordField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            oldPasswordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            oldPasswordField.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            passwordFieldIcon.centerYAnchor.constraint(equalTo: oldPasswordField.centerYAnchor),
            passwordFieldIcon.leadingAnchor.constraint(equalTo: oldPasswordField.leadingAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            newPasswordLabel.bottomAnchor.constraint(equalTo: newPasswordField.topAnchor),
            newPasswordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            newPasswordLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            newPasswordLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            newPasswordField.topAnchor.constraint(equalTo: self.oldPasswordField.bottomAnchor, constant: 60),
            newPasswordField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            newPasswordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            newPasswordField.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            passwordFieldIcon1.centerYAnchor.constraint(equalTo: newPasswordField.centerYAnchor),
            passwordFieldIcon1.leadingAnchor.constraint(equalTo: newPasswordField.leadingAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            reTypePasswordLabel.bottomAnchor.constraint(equalTo: reTypePasswordField.topAnchor),
            reTypePasswordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            reTypePasswordLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            reTypePasswordLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            reTypePasswordField.topAnchor.constraint(equalTo: self.newPasswordField.bottomAnchor, constant: 60),
            reTypePasswordField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            reTypePasswordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            reTypePasswordField.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            passwordFieldIcon2.centerYAnchor.constraint(equalTo: reTypePasswordField.centerYAnchor),
            passwordFieldIcon2.leadingAnchor.constraint(equalTo: reTypePasswordField.leadingAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            saveChangeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
            saveChangeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            saveChangeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            saveChangeButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configLabels(){
        [oldPasswordLabel,newPasswordLabel,reTypePasswordLabel].forEach{
            $0.font = UIFont(name: "Montserrat-Medium", size: 16)
            $0.textColor = .lightGray
        }
        oldPasswordLabel.text = "OLD PASSWORD"
        newPasswordLabel.text = "NEW PASSWORD"
        reTypePasswordLabel.text = "RE-TYPE PASSWORD"
    }
    
    private func configImage() {
        [passwordFieldIcon,passwordFieldIcon1,passwordFieldIcon2].forEach {
            $0.image = UIImage(named: "passwordIconImage")
        }
    }
    
    private func configTextField() {
        [oldPasswordField,newPasswordField,reTypePasswordField].forEach {
            $0.delegate = self
            $0.textColor = .white
            let paddingInField: CGFloat = 10
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingInField, height: $0.bounds.height))
            $0.leftView = paddingView
            $0.leftViewMode = .always
            $0.layer.borderColor = UIColor.defaultBorderColor
            $0.layer.borderWidth = 1.0
            $0.backgroundColor = .blueGray
            $0.textColor = .white
            $0.layer.cornerRadius = 5
        }
    }
    @objc private func saveChangeButtonIsPressed(_ sender: UIButton) {
        guard
            let oldPassword = oldPasswordField.text,
            let newPassword = newPasswordField.text,
            let reTypePassword = reTypePasswordField.text,
            !oldPassword.isEmpty,
            !newPassword.isEmpty,
            !reTypePassword.isEmpty
        else {
            return
        }
        
        let realm = try! Realm()
        guard let currentUser = realm.objects(User.self).filter("username == %@", LoginUser.shared.user?.username ?? "").first else {
            return
        }
        
        if currentUser.password == oldPassword {
            if newPassword == reTypePassword {
                if oldPassword == newPassword {
                    let alertController = UIAlertController(title: "Warning",
                    message: "Old password and new password are the same", preferredStyle: .alert)
                    
                    let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okayAction)
                    present(alertController, animated: true, completion: nil)
                } else {
                    try! realm.write {
                        currentUser.password = newPassword
                    }
                    let alertController = UIAlertController(title: "Successfully",
                    message: "Password changed successfully", preferredStyle: .alert)
                    
                    let okayAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                        self?.oldPasswordField.text = ""
                        self?.newPasswordField.text = ""
                        self?.reTypePasswordField.text = ""
                        self?.navigationController?.popViewController(animated: true)
                    }
                    alertController.addAction(okayAction)
                    present(alertController, animated: true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "Error",
                                                        message: "New password and the re-type password are not the same",
                                                        preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "Error",
                                                    message: "Old password is incorrect",
                                                    preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    private func configSaveChangeButton() {
        saveChangeButton.setTitle("Save Change", for: .normal)
        saveChangeButton.layer.cornerRadius = 5
        saveChangeButton.backgroundColor = .crimson
        saveChangeButton.setTitleColor(.white, for: .normal)
        saveChangeButton.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        
        saveChangeButton.addTarget(self, action: #selector(saveChangeButtonIsPressed), for: .touchUpInside)
    }
}
extension ChangePasswordViewController: UITextFieldDelegate {
    /// Приховує іконку поля коли користувач починає взаємодію з полем
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.selectedBorderColor
        
        switch textField {
        case oldPasswordField:
            passwordFieldIcon.isHidden = true
        case newPasswordField:
            passwordFieldIcon1.isHidden = true
        case reTypePasswordField:
            passwordFieldIcon2.isHidden = true
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
        case oldPasswordField:
            passwordFieldIcon.isHidden = false
        case newPasswordField:
            passwordFieldIcon1.isHidden = false
        case reTypePasswordField:
            passwordFieldIcon2.isHidden = false
        default:
            break;
        }
    }
}
