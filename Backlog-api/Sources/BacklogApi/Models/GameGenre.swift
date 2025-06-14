import Foundation
import Fluent 
import Vapor

final class GameGenre: Model, Content {
    static let schema = "gamesGenres"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "gameId")
    var game: Game

    @Parent(key: "genreId")
    var genre: Genre

    init() { }

    init(id: UUID? = nil, gameId: UUID, genreId: UUID) {
        self.id = id
        self.$game.id = gameId
        self.$genre.id = genreId
    }
}