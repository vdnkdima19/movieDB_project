import Foundation

protocol PageOfMovieVCProtocol {
    ///добавлення елементів на view
    func addSubviews()
    ///встановлення кольорів та шрифтів для Labels
    func setTextColorAndFontsOfLabels()
    ///встановлення зображення для фонової картинки
    func setBackImage()
    ///встановлення зображення для постера
    func setPoster()
    ///встановлення заднього кольору для всіх ScrollView
    func setBackgrounColorOfAllScrollView()
    ///встановлення заднього кольору для всіх TableView
    func setBackgroundColorOfAllTableView()
    ///реєстрування cell для всіх TableView
    func registerCellOfTableViews()
    func setReleaseAndRatingMovie()
    ///встановлення назви для фільму
    func setTextOfTitleOfMovieLabel()
    ///встановлення розмірів для всіх елементів
    func setConstraints()
    ///встановлення текстів для labels
    ///встановлення 3 видів жанру для одного фільму
    func setGenreOfMovie()
    ///встановлення функціоналу для ratingAndStarsStackView
    ///**Parameter:**
    ///- countOfElements: оцінка фильму від глядачів
    func configStarsStackView(_ countOfElements: Int)
    ///встановлення опису фильму
    func setDescriptionText()
    ///встановлення оцінки фільму зарками в 5-бальній системі
    func setVoteAverageStars()
    ///встановлення властивостей для castAndCrewStackView
    func configCastAndCrewStackView()
    ///встановлення властивостей для photosStackView
    func configPhotosStackView()
    ///встановлення властивостей для videosStackView
    func configVideoStackView()
    ///встановлення властивостей для reviewStackView
    func configReviewStackView()
    ///встановлення розміру для scrollView
    func setSizeOfScrollView()
    ///встановлення розміру для photosScrollView
    ///**Parameter:**
    ///- photosCount: кількість наявних фото фільму
    func setSizeOfPhotosScroll(photosCount: Int)
    ///встановлення розміру для videosScrollView
    ///**Parameter:**
    ///- videosCount: кількість наявних відеоматеріалів фільму
    func setSizeOfVideosScroll(videosCount: Int)
    ///запит на отримання списку всіх акторів з конкретного фільму по ID
    ///**Parameter:**
    ///- movieID: номер фільму
    func fetchCast(movieID: Int)
    ///запит на отримання всіх кадрів з конкретного фільму по ID
    ///**Parameter:**
    ///- movieID: номер фільму
    func fetchMovieFrames(movieId: Int)
    ///запит на отримання всіх відео з конкретного фільму по ID
    ///**Parameter:**
    ///- movieID: номер фільму
    func fetchVideos(movieId: Int)
    ///запит на отримання всіх відгуків з конкретного фільму по ID
    ///**Parameter:**
    ///- movieID: номер фільму
    func fetchReviews(movieId: Int)
}
