import RealmSwift
import Foundation
class User: Object {
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var isAdmin: Bool = false
    @objc dynamic var isBanned: Bool = false
}

