import Vapor
import Fluent

struct GameController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws{
        let games = routes.grouped("games")
        games.get(use: self.getGames)
        games.post(use: self.create)
    }

    func getGames(req: Request) async throws -> [GameDTO] {
        let gamesDB = try await Game.query(on: req.db)
            .with(\.$platforms)
            .with(\.$genres)
            .all()
        return gamesDB.map { game in
            GameDTO(
                id: game.id,
                title: game.title,
                desc: game.desc,
                releaseDate: game.releaseDate,
                developer: game.developer,
                publisher: game.publisher,
                platform: game.platforms.map { $0.name },
                genres: game.genres.map { $0.name },
                image: game.image
            )
        }
    }

    func create(req: Request) async throws -> GameDTO {
        let gameDTO = try req.content.decode(GameDTO.self)
        let game = Game()
        game.title = gameDTO.title
        game.desc = gameDTO.desc
        game.releaseDate = gameDTO.releaseDate
        game.developer = gameDTO.developer
        game.publisher = gameDTO.publisher
        game.image = gameDTO.image ?? ""

        try await game.save(on: req.db)
        return gameDTO
    }
}