import Fluent

final class GamePlatform: Model, @unchecked Sendable {
    static let schema = "gamePlatforms"

    @ID()
    var id: UUID?

    @Parent(key: "gameId")
    var game: Game

    @Parent(key: "platformId")
    var platform: Platform

    init() {}

    init(id: UUID? = nil, gameId: UUID, platformId: UUID) {
        self.id = id
        self.$game.id = gameId
        self.$platform.id = platformId
    }
}