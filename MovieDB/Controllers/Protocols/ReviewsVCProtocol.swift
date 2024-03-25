import Foundation

protocol ReviewsVCProtocol {
    /// Відгуки до фільму
    var reviews: [ReviewResult] { get set }
    
    /// Підвантажує відгуки
    func fetchReviews(movieId: Int)
    /// Підраховує загальний рейтинг фільму
    func calculateAverageRating()
    /// Виставляє рейтинг в числовому та зірковому значенні
    func setupStarsStackView(rating: Int)
    
    /// Налаштовує елементи данного ViewController
    func setupElements()
    /// Виставляє обмеження ( constraints ) для елементів view
    func setupConstraints()
}
