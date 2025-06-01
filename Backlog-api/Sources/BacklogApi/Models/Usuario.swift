import Foundation
import Fluent

final class Usuario : Model, @unchecked Sendable {

    static let schema = "usuarios"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Field(key: "email")
    var email: String

    @Field(key: "password")
    var password: String

    @Field(key: "image")
    var image: String?

    init(){}

    init(id: UUID?, username: String, email: String, password: String, image: String? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
        self.image = image
    }
}