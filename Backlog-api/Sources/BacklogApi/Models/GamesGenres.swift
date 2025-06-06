import Foundation
import Fluent 
import Vapor

final class GamesGenres: Model, Content {
    static let schema = "games_genres"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "game_id")
    var game: Game

    @Parent(key: "genre_id")
    var genre: Genre

    init() { }

    init(id: UUID? = nil, gameId: UUID, genreId: UUID) {
        self.id = id
        self.$game.id = gameId
        self.$genre.id = genreId
    }
}