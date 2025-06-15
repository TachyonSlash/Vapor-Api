import Fluent
import Vapor

final class Platform: Model, Content, @unchecked Sendable {
    static let schema = "platforms"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    init() {}
}