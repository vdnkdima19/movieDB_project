import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var isAdmin: Bool = false
    @objc dynamic var isBanned: Bool = false
    @objc dynamic var avatarImageData: Data = Data()
}

