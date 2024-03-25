import Foundation
import RealmSwift

class ChatMessage: Object {
    @objc dynamic var user: String = ""
    @objc dynamic var admin: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var messageId: Int = 0
    @objc dynamic var isAdmin: Bool = false
    @objc dynamic var isCheckedMessage: Bool = false
    @objc dynamic var date: Date = Date(timeIntervalSinceNow: 0)
}
