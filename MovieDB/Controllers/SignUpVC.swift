import UIKit
import RealmSwift

class SignUpVC: UIViewController {
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let confirmPasswordField = UITextField()
    private var allFields = [UITextField]()
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
    
    private let confirmPasswordIcon: UIImageView = {
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
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.text = "CONFIRM PASSWORD"
        return label
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = .crimson
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 18)
        button.setTitle("Create", for: .normal)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage( UIImage(named: "ButtonBack"), for: .normal)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        [passwordField, usernameField].forEach{
            $0.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkBlue
        
        setupElements()
        setupConstraints()
        
        allFields =  [usernameField, passwordField, confirmPasswordField]
    }
    
    /// Налаштовує елементи для данного ViewController
    private func setupElements(){
        let paddingInField: CGFloat = 10
        
        [usernameLabel, passwordLabel, confirmPasswordLabel].forEach{
            $0.textColor = .lightGray
        }
        
        [usernameField, passwordField, confirmPasswordField].forEach{
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
        
        [usernameLabel, usernameField, usernameIcon, passwordLabel, passwordField, passwordIcon, confirmPasswordLabel, confirmPasswordField,  confirmPasswordIcon, createButton, backButton].forEach{
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addActions()
    }
    
    /// Виставляє обмеження ( constraints ) для елементів ViewController
    private func setupConstraints(){
        let heightFields: CGFloat = 50
        let heightLabels: CGFloat = 50
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45),
            backButton.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            usernameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            usernameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            usernameLabel.heightAnchor.constraint(equalToConstant: heightLabels)
        ])
        
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
            usernameField.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            usernameField.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            usernameField.heightAnchor.constraint(equalToConstant: heightFields)
        ])
        
        NSLayoutConstraint.activate([
            usernameIcon.centerYAnchor.constraint(equalTo: usernameField.centerYAnchor),
            usernameIcon.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: usernameField.bottomAnchor),
            passwordLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            passwordLabel.heightAnchor.constraint(equalToConstant: heightLabels)
        ])
        
        NSLayoutConstraint.activate([
            passwordIcon.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor),
            passwordIcon.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor),
            passwordField.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: heightFields)
        ])
        
        NSLayoutConstraint.activate([
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            confirmPasswordLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            confirmPasswordLabel.heightAnchor.constraint(equalToConstant: heightLabels)
        ])
        
        NSLayoutConstraint.activate([
            confirmPasswordField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor),
            confirmPasswordField.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            confirmPasswordField.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: heightFields)
        ])
        
        NSLayoutConstraint.activate([
            confirmPasswordIcon.centerYAnchor.constraint(equalTo: confirmPasswordField.centerYAnchor),
            confirmPasswordIcon.leadingAnchor.constraint(equalTo: confirmPasswordField.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 40),
            createButton.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            createButton.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    /// Підклеслює пусті поля червоним
    func markEmptyFields() {
        for field in allFields {
            if let text = field.text, text.isEmpty {
                field.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    // Перевірає пароль на валідність
    func validatePassword(_ password: String) -> Bool {
        guard isPasswordLengthValid(password) else {
            return false
        }
        
        guard startsWithLetter(password) else {
            return false
        }
        
        guard containsUppercaseLetter(password) else {
            return false
        }
        
        guard containsDigit(password) else {
            return false
        }
        
        guard doesNotContainSpecialCharacters(password) else {
            return false
        }
        
        return true
    }

    /// Перевіряє довжіну паролю
    private func isPasswordLengthValid(_ password: String) -> Bool {
        guard password.count >= 8 else {
            showAlert("Password less than 8 characters")
            return false
        }
        
        return true
    }

    /// Перевіряє початковий символ
    private func startsWithLetter(_ password: String) -> Bool {
        guard let firstCharacter = password.unicodeScalars.first, CharacterSet.letters.contains(firstCharacter) else {
            showAlert("The first character must be a letter")
            return false
        }
        
        return true
    }

    /// Перевірає вміст букв верхнього регістру
    private func containsUppercaseLetter(_ password: String) -> Bool {
        guard let uppercaseLetterRange = password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) else {
            showAlert("Password must contain at least 1 capital letter")
            return false
        }
        
        return true
    }

    /// Перевірає вміст цифр
    private func containsDigit(_ password: String) -> Bool {
        let decimalDigitsCharacterSet = CharacterSet(charactersIn: "0123456789")
        guard password.rangeOfCharacter(from: decimalDigitsCharacterSet) != nil else {
            showAlert("Password must contain at least 1 digit")
            return false
        }
        
        return true
    }

    /// Перевіряє чи не містить забороненіх символів
    private func doesNotContainSpecialCharacters(_ password: String) -> Bool {
        let forbiddenCharacterSet = CharacterSet(charactersIn: " ,\\/\u{00B1}?")
        guard password.rangeOfCharacter(from: forbiddenCharacterSet) == nil else {
            showAlert("The password must not contain the following characters: space, ',', '\\', '/', '±', '?'")
            return false
        }
        
        return true
    }
    
    /// Виводить повідомлення з кнопкою ( ОК )
    func showAlert(_ title: String) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func addActions(){
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeypad))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    /// Переходить на минулий контроллер
    @objc private func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    
    /// Створює акаунт і передає дані в UserDefaults
    @objc func createAccount() {
        markEmptyFields()
        
        guard let password = passwordField.text, let confirmPassword = confirmPasswordField.text else {
            return
        }
        
        if validatePassword(password) {
            if password == confirmPassword {
                guard let usernameValue = usernameField.text, !usernameValue.isEmpty else {
                           showAlert("Username is required")
                           return
                       }
                
                let realm = try! Realm()
                
                // Перевірка, чи існує користувач з таким логіном
                let existingUser = realm.objects(User.self).filter("username = %@", usernameValue).first
                if existingUser != nil {
                    showAlert("Such a login already exists")
                    return
                }
                
                // Створення нового об'єкту User
                let newUser = User()
                newUser.username = usernameValue
                newUser.password = password
                newUser.isAdmin = false
                newUser.isBanned = false
                newUser.isRepairBanned = false
                // Збереження об'єкту User в Realm
                try! realm.write {
                    realm.add(newUser)
                }
                navigationController?.popViewController(animated: true)
            } else {
                showAlert("Passwords do not match")
            }
        }
    }
    
    // Приховуємо клавиатуру
    @objc private func hideKeypad() {
        view.endEditing(true)
    }
}


extension SignUpVC: UITextFieldDelegate {
    /// Приховує іконку поля коли користувач починає взаємодію з полем
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.selectedBorderColor
        
        switch textField {
        case usernameField:
            usernameIcon.isHidden = true
            
        case passwordField:
            passwordIcon.isHidden = true
            
        case confirmPasswordField:
            confirmPasswordIcon.isHidden = true
            
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
            
        case confirmPasswordField:
            confirmPasswordIcon.isHidden = false
            
        default:
            break;
        }
    }
}
