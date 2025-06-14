import Fluent
import Vapor

final class Genre: Model, Content {
    static let schema = "genres"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Siblings(through: GameGenre.self, from: \.$genre, to: \.$game)
    var games: [Game]

    init() {}
}