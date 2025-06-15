import Vapor 
import Fluent

struct GamesGenresController : RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let gamesGenres = routes.grouped("gameGenres")
        
        gamesGenres.get(use: self.getGamesGenres)
        gamesGenres.post(use: self.create)
    }

    func getGamesGenres(req: Request) async throws -> [GamesGenresDTO] {
        var gameGenreMock: [GamesGenresDTO] = []
        let gameGenresDB = try await GameGenre.query(on: req.db).all()
        gameGenresDB.forEach { gameGenre in
            let dto = GamesGenresDTO(
                id: gameGenre.id,
                gameId: gameGenre.$game.id,
                genreId: gameGenre.$genre.id
            )
            gameGenreMock.append(dto)
        }
        return gameGenreMock
    }

    func create(req: Request) async throws -> GamesGenresDTO {
        let dto = try req.content.decode(GamesGenresDTO.self)
        let gameGenre = GameGenre(
            id: dto.id,
            gameId: dto.gameId,
            genreId: dto.genreId
        )
        try await gameGenre.save(on: req.db)
        return dto
    }
}