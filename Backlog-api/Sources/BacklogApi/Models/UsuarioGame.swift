import Fluent
import Vapor

final class UsuarioGame: Model, Content {
    static let schema = "usuarioGames"

    @ID()
    var id: UUID?

    @Parent(key: "usuario_id")
    var usuario: Usuario

    @Parent(key: "juego_id")
    var game: Game

    @Field(key: "status")
    var status: String

    @OptionalField(key: "review")
    var review: String?

    @OptionalField(key: "rating")
    var rating: Double?

    @OptionalField(key: "fecha_agregado")
    var fechaAgregado: Date?

    init() {}

    init(id: UUID? = nil, usuarioID: UUID, gameID: UUID, status: String, review: String? = nil, rating: Double? = nil, fechaAgregado: Date? = nil) {
        self.id = id
        self.$usuario.id = usuarioID
        self.$game.id = gameID
        self.status = status
        self.review = review
        self.rating = rating
        self.fechaAgregado = fechaAgregado
    }
}