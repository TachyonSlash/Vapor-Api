import Vapor
import Fluent

struct GameController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws{
        let games = routes.grouped("games")

        games.get(use: self.getGames)
        games.post(use: self.create)
    }

    func getGames(req: Request) async throws -> [GameDTO] {
        var gameMock: [GameDTO] = []
        let gamesDB = try await Game.query(on: req.db).all()
        gamesDB.forEach { game in
            var gameDTO = GameDTO(id: game.id, title: game.title, desc: game.desc, review: game.review, rating: game.rating, releaseDate: game.releaseDate, developer: game.developer, publisher: game.publisher, platform: game.platform, genres: game.genres, image: game.image)
            gameMock.append(gameDTO)
        }
        return gameMock
    }

    func create(req: Request) async throws -> GameDTO {
        let gameDTO = try req.content.decode(GameDTO.self)
        let game = Game(id: gameDTO.id, title: gameDTO.title, desc: gameDTO.desc, review: gameDTO.review, rating: gameDTO.rating, releaseDate: gameDTO.releaseDate, developer: gameDTO.developer, publisher: gameDTO.publisher, platform: gameDTO.platform, genres: gameDTO.genres, image: gameDTO.image)

        try await game.save(on: req.db)
        return gameDTO
    }
}