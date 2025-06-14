import Vapor
import Fluent

struct GamePlatformController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let gamePlatforms = routes.grouped("gamePlatforms")
        
        gamePlatforms.get(use: self.getGamePlatforms)
        gamePlatforms.post(use: self.create)
    }

    func getGamePlatforms(req: Request) async throws -> [GamePlatformDTO] {
        var gamePlatformMock: [GamePlatformDTO] = []
        let gamePlatformsDB = try await GamePlatform.query(on: req.db).all()
        gamePlatformsDB.forEach { gamePlatform in
            let dto = GamePlatformDTO(
                id: gamePlatform.id,
                gameId: gamePlatform.gameId,
                platformId: gamePlatform.platformId
            )
            gamePlatformMock.append(dto)
        }
        return gamePlatformMock
    }

    func create(req: Request) async throws -> GamePlatformDTO {
        let dto = try req.content.decode(GamePlatformDTO.self)
        let gamePlatform = GamePlatform(
            id: dto.id,
            gameId: dto.gameId,
            platformId: dto.platformId
        )
        try await gamePlatform.save(on: req.db)
        return dto
    }
}