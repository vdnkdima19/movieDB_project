import Foundation
import RealmSwift
import UIKit

class User: Object {
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var isAdmin: Bool = false
    @objc dynamic var isBanned: Bool = false
    @objc dynamic var isRepairBanned: Bool = false
    @objc dynamic var bannedDescription: String = ""
    @objc dynamic var avatarImageData: Data = UIImage(systemName: "person.circle.fill")?.jpegData(compressionQuality: 1) ?? Data()
}

