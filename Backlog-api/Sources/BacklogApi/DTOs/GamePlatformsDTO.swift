import Vapor
import Foundation

struct GamePlatformDTO: Content {
    var id: UUID?
    var gameId: UUID
    var platformId: UUID

    init(id: UUID? = nil, gameId: UUID, platformId: UUID) {
        self.id = id
        self.gameId = gameId
        self.platformId = platformId
    }
}