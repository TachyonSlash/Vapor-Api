import Vapor 
import Foundation

struct GamesGenresDTO : Content {
    var id: UUID?
    var gameId: UUID
    var genreId: UUID

    init(id: UUID? = nil, gameId: UUID, genreId: UUID) {
        self.id = id
        self.gameId = gameId
        self.genreId = genreId
    }
}