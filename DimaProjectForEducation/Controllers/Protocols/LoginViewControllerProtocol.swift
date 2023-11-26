import UIKit

protocol LoginViewControllerProtocol {
    var usernameField: UITextField { get }
    var passwordField: UITextField { get }
    /// Приховує клавіатуру
    func hideKeypad()
    /// Перехід на екран регестрації
    func goToSignUp()
    /// Зміннює видимість паролю
    func changePassVisibility()
    /// Вхід в акаунт за данними введеними в текстові поля usernameField, enteredPassword
    func loginUser()
    /// Виводить повідомлення що аккаунт не знайденій
    func showMissingAlert()
    /// Підклеслює пусті поля червоним
    func markEmptyFields()

    /// Налаштовує елементи данного ViewController
    func setupElements()
    /// Добавляє дії до кнопок
    func addActions()
    /// Виставляє обмеження ( constraints ) для елементів ViewController
    func setupConstraints()
}
