import Vapor
import Foundation

struct UsuarioDTO : Content{
    var id: UUID?
    var username: String
    var email: String
    var password: String
    var image: String?

    init(id: UUID? = nil, username: String, email: String, password: String, image: String? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
        self.image = image
    }
}