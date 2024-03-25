import UIKit
import RealmSwift

class LoginVC: UIViewController, LoginViewControllerProtocol {
    internal let usernameField = UITextField()
    internal let passwordField = UITextField()
    private var allFields: [UITextField] = []
    var signUp = UIButton()
    private let usernameIcon: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: "UserIcon") {
            imageView.image = image
        }
        return imageView
    }()
    
    private let passwordIcon: UIImageView = {
        
        let imageView = UIImageView()
        if let image = UIImage(named: "PadlockIcon") {
            imageView.image = image
        }
        return imageView
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.text = "USER NAME"
        return label
    }()
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.text = "PASSWORD"
        return label
    }()
    private let showPasswordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        if let image = UIImage(named: "Eye") {
            button.setImage(image, for: .normal)
        }
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = .crimson
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.crimson, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        button.setTitle("Sign Up", for: .normal)
        return button
    }()
    // MARK: Functionality setup code
    /// Приховує клавіатуру
    @objc internal func hideKeypad() {
        view.endEditing(true)
    }
    /// Перехід на екран регестрації
    @objc internal func goToSignUp(){
        let auto = SignUpVC()
        navigationController?.pushViewController(auto, animated: true)
    }
    /// Зміннює видимість паролю
    @objc internal func changePassVisibility() {
        passwordField.isSecureTextEntry.toggle()
        let buttonImage = passwordField.isSecureTextEntry ? UIImage(named: "Eye") : UIImage(named: "EyeOff")
        showPasswordButton.setImage(buttonImage, for: .normal)
    }
    /// Підклеслює пусті поля червоним
    internal func markEmptyFields() {
        for field in allFields {
            if let text = field.text, text.isEmpty {
                field.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    /// Виводить повідомлення що акаунт не найдено
    // MARK: Design setup code
    override func viewWillAppear(_ animated: Bool) {
        [passwordField, usernameField].forEach{
            $0.text = ""
        }
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkBlue
        setupElements()
        addActions()
        setupConstraints()
        allFields = [usernameField, passwordField]
        
        func getAppDocumentsDirectory() -> URL? {
            if let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                return documentsPath
            }
            return nil
        }

        if let documentsDirectory = getAppDocumentsDirectory() {
            print("Documents Directory: \(documentsDirectory)")
        } else {
            print("Unable to retrieve documents directory.")
        }
    }
    /// Налаштовує елементи для данного ViewController
    internal func setupElements(){
        let paddingInField: CGFloat = 10
        
        [usernameLabel, passwordLabel].forEach{
            $0.textColor = .lightGray
        }
        
        [usernameField, passwordField].forEach{
            $0.delegate = self
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingInField, height: $0.bounds.height))
            $0.leftView = paddingView
            $0.leftViewMode = .always
            $0.layer.borderColor = UIColor.defaultBorderColor
            $0.layer.borderWidth = 1.0
            $0.backgroundColor = .blueGray
            $0.textColor = .white
            $0.layer.cornerRadius = 5
        }
        passwordField.isSecureTextEntry = true
        
        [usernameLabel, usernameField, usernameIcon, passwordLabel, passwordField, showPasswordButton ,passwordIcon, loginButton, signUpButton].forEach{
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    internal func addActions(){
        showPasswordButton.addTarget(self, action: #selector(changePassVisibility), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeypad))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    internal func setupConstraints(){
        NSLayoutConstraint.activate([
            usernameLabel.bottomAnchor.constraint(equalTo: usernameField.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            usernameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            usernameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            usernameField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            usernameField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            usernameField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            usernameField.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            usernameIcon.centerYAnchor.constraint(equalTo: usernameField.centerYAnchor),
            usernameIcon.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            passwordLabel.bottomAnchor.constraint(equalTo: passwordField.topAnchor),
            passwordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            passwordLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            passwordLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            passwordIcon.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor),
            passwordIcon.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            showPasswordButton.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor),
            showPasswordButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor, constant: -10),
            showPasswordButton.widthAnchor.constraint(equalToConstant: 30),
            showPasswordButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            passwordField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            passwordField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45),
            signUpButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func showPassword() {
        passwordField.isSecureTextEntry.toggle()
        let buttonImage = passwordField.isSecureTextEntry ? UIImage(named: "Eye") : UIImage(named: "EyeOff")
        showPasswordButton.setImage(buttonImage, for: .normal)
    }
    
    internal func showMissingAlert() {
        let alertController = UIAlertController(title: "Your account was not found", message: "", preferredStyle: .alert)
        
        let createAccount = UIAlertAction(title: "Create Account", style: .default){ _ in
            self.goToSignUp()
        }
        alertController.addAction(createAccount)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        present(alertController, animated: true, completion: nil)
    }
    
    internal func userIsBannedAlert() {
        let alertController = UIAlertController(title: "Your account is banned", message: "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alertController, animated: true, completion: nil)
    }
    
    /// Робить вхід акаунт за данними введеними в поля usernameField, enteredPassword
    @objc internal func loginUser() {
        
        markEmptyFields()

        guard let enteredUsername = usernameField.text, let enteredPassword = passwordField.text else {
            return
        }

        let realm = try! Realm()

        // Перевірка, чи існує користувач з таким логіном
        let user = realm.objects(User.self).filter("username = %@", enteredUsername).first
        
        if let user = user, user.password == enteredPassword {
            if !user.isBanned  {
                LoginUser.shared.user = user
                let TabBarController = MovieTabBarController()
                navigationController?.pushViewController(TabBarController, animated: true)
                
            } else {
                userIsBannedAlert()
            }
        } else {
            showMissingAlert()
        }
        
    }
  
}
extension LoginVC: UITextFieldDelegate {
    /// Приховує іконку поля коли користувач починає взаємодію з полем
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.selectedBorderColor
        
        switch textField {
        case usernameField:
            usernameIcon.isHidden = true
            
        case passwordField:
            passwordIcon.isHidden = true
            
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
        case usernameField:
            usernameIcon.isHidden = false
            
        case passwordField:
            passwordIcon.isHidden = false

        default:
            break;
        }
    }
}
