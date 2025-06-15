import Fluent

final class GameGenre: Model, @unchecked Sendable {
    static let schema = "gameGenres"

    @ID()
    var id: UUID?

    @Parent(key: "gameId")
    var game: Game

    @Parent(key: "genreId")
    var genre: Genre

    init() {}

    init(id: UUID? = nil, gameId: UUID, genreId: UUID) {
        self.id = id
        self.$game.id = gameId
        self.$genre.id = genreId
    }
}