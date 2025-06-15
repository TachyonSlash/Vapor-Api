import Fluent
import Vapor

final class UsuarioGame: Model, Content, @unchecked Sendable {
    static let schema = "usuarioGames"

    @ID()
    var id: UUID?

    @Parent(key: "usuarioId")
    var usuario: Usuario

    @Parent(key: "juegoId")
    var game: Game

    @Field(key: "status")
    var status: String

    @OptionalField(key: "review")
    var review: String?

    @OptionalField(key: "rating")
    var rating: Double?

    @OptionalField(key: "fechaAgregado")
    var fechaAgregado: Date?

    init() {}

    init(id: UUID? = nil, usuarioId: UUID, juegoId: UUID, status: String, review: String? = nil, rating: Double? = nil, fechaAgregado: Date? = nil) {
        self.id = id
        self.$usuario.id = usuarioId
        self.$game.id = juegoId
        self.status = status
        self.review = review
        self.rating = rating
        self.fechaAgregado = fechaAgregado
    }
}