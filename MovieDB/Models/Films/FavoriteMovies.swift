import Foundation
import RealmSwift

class FavoriteMovies {
    static let shared = FavoriteMovies()
    
    var moviesArr: [MovieInfoResult] = []
    
    public func reloadArr(allMovies:[MovieInfoResult], username: String) {
        let realm = try! Realm()
        let listOfMovies = realm.objects(ListOfRecomendationMovies.self).where({
            $0.username == LoginUser.shared.user?.username ?? ""
        })
        var resultArr: [MovieInfoResult] = []
        listOfMovies.forEach { selectedFilm in
            if let movies = allMovies.first(where: {$0.id == selectedFilm.filmId}) {
                resultArr.append(movies)
            }
        }
        moviesArr = resultArr
    }
}
