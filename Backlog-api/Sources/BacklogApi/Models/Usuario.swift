import Fluent
import Vapor

final class Usuario: Model, Content, @unchecked Sendable {
    static let schema = "usuarios"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Field(key: "email")
    var email: String

    @Field(key: "password")
    var password: String

    @OptionalField(key: "image")
    var image: String?

    init() {}
}