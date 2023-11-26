import Foundation
protocol MovieFramesVCProtocol {
    /// Кадри з фільму
    var movieFrames: [Backdrops] { get set }
    
    /// Підвантажує кадри
    func fetchMovieFrames(movieId: Int)
    
    /// Добавляє UITableView на view
    func setupTableView()
    /// Виставляє обмеження ( constraints ) для елементів view
    func setupConstraints()
}
