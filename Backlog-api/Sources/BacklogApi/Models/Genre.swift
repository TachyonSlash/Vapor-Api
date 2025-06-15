import Fluent
import Vapor

final class Genre: Model, Content, @unchecked Sendable {
    static let schema = "genres"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    init() {}
}