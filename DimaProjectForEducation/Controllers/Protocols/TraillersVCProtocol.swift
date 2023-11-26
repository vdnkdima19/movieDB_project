import Foundation
import UIKit

protocol TraillersVCProtocol {
    /// Треллери
    var trailers: [VideoResults] {get set}
    /// Підвантажує треллери
    func fetchTrailers(movieID: Int)
    /// Налаштовує елементи данного ViewController
    func setupElements()
    /// Налаштовує UITableView на view
    func setupTableView()
    /// Виставляє обмеження ( constraints ) для елементів view
    func setupConstraints()
}
