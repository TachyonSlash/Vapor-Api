import Vapor 
import Fluent

struct GamesGenresController : RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let gamesGenres = routes.grouped("gameGenres")
        
        gamesGenres.get(use: self.getGamesGenres)
        gamesGenres.post(use: self.create)
    }

    func getGamesGenres(req: Request) async throws -> [GameGenreDTO] {
        var gameGenreMock: [GameGenreDTO] = []
        let gameGenresDB = try await GameGenre.query(on: req.db).all()
        gameGenresDB.forEach { gameGenre in
            let dto = GameGenreDTO(
                id: gameGenre.id,
                gameId: gameGenre.gameId,
                genreId: gameGenre.genreId
            )
            gameGenreMock.append(dto)
        }
        return gameGenreMock
    }

    func create(req: Request) async throws -> GameGenreDTO {
        let dto = try req.content.decode(GameGenreDTO.self)
        let gameGenre = GameGenre(
            id: dto.id,
            gameId: dto.gameId,
            genreId: dto.genreId
        )
        try await gameGenre.save(on: req.db)
        return dto
    }
}