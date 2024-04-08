import Foundation
import RealmSwift
import UIKit

class ListOfRecomendationMovies: Object {
    @objc dynamic var username: String = ""
    @objc dynamic var filmId: Int = 0
    @objc dynamic var filmStatus: Int = 0
}

