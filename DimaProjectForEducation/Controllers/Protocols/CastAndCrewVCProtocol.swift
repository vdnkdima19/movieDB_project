import Foundation

protocol CastAndCrewVCProtocol {
    /// Інформація про актерів
    var cast: [Cast] { get set }
    /// Підвантажує акторів
    func fetchCast(movieID: Int)
    /// Налаштовує елементи данного ViewController
    func setupElements()
    /// Добавляє UITableView на view
    func setupTableView()
    /// Виставляє обмеження ( constraints ) для елементів view
    func setupConstraints()
}
