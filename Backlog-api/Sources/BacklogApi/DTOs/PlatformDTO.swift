import Vapor
import Foundation

struct PlatformDTO: Content {
    var id: UUID?
    var name: String

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}