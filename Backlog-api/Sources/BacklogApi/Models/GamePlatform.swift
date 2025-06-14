import Fluent

final class GamePlatform: Model {
    static let schema = "gamePlatforms"

    @ID()
    var id: UUID?

    @Parent(key: "gameId")
    var game: Game

    @Parent(key: "platformId")
    var platform: Platform

    init() {}

    init(gameID: UUID, platformID: UUID) {
        self.$game.id = gameID
        self.$platform.id = platformID
    }
}