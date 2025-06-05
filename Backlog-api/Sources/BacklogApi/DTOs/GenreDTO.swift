import Vapor
import Foundation

struct GenreDTO: Content {
    var id: UUID?
    var name: String

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}