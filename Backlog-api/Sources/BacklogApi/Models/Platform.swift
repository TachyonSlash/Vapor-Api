import Fluent
import Vapor
import Foundation

final class Platform: Model, Content {
    static let schema = "platforms"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    init() { }

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
