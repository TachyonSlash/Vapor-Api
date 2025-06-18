import Vapor
import Fluent

struct GameController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let games = routes.grouped("games")
        games.get(use: self.getGames)
        games.post(use: self.create)
        games.put(":id", use: self.update)
        games.delete(":id", use: self.delete)
        games.get("platforms", use: self.getGamePlatforms)
        games.get("genres", use: self.getGameGenres)
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

        if !gameDTO.platform.isEmpty {
            let platforms = try await Platform.query(on: req.db)
                .filter(\.$name ~~ gameDTO.platform)
                .all()
            try await game.$platforms.attach(platforms, on: req.db)
        }

        if !gameDTO.genres.isEmpty {
            let genres = try await Genre.query(on: req.db)
                .filter(\.$name ~~ gameDTO.genres)
                .all()
            try await game.$genres.attach(genres, on: req.db)
        }

        return gameDTO
    }

    func update(req: Request) async throws -> GameDTO {
        let gameId = try req.parameters.require("id", as: UUID.self)
        let updateDTO = try req.content.decode(GameDTO.self)

        guard let game = try await Game.find(gameId, on: req.db) else {
            throw Abort(.notFound, reason: "Game not found")
        }

        game.title = updateDTO.title
        game.desc = updateDTO.desc
        game.releaseDate = updateDTO.releaseDate
        game.developer = updateDTO.developer
        game.publisher = updateDTO.publisher
        game.image = updateDTO.image ?? ""

        try await game.save(on: req.db)

        if !updateDTO.platform.isEmpty {
            let platforms = try await Platform.query(on: req.db)
                .filter(\.$name ~~ updateDTO.platform)
                .all()
            try await game.$platforms.detachAll(on: req.db)
            try await game.$platforms.attach(platforms, on: req.db)
        }

        if !updateDTO.genres.isEmpty {
            let genres = try await Genre.query(on: req.db)
                .filter(\.$name ~~ updateDTO.genres)
                .all()
            try await game.$genres.detachAll(on: req.db)
            try await game.$genres.attach(genres, on: req.db)
        }

        return GameDTO(
            id: game.id,
            title: game.title,
            desc: game.desc,
            releaseDate: game.releaseDate,
            developer: game.developer,
            publisher: game.publisher,
            platform: updateDTO.platform,
            genres: updateDTO.genres,
            image: game.image
        )
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest, reason: "ID is required for deletion")
        }

        guard let game = try await Game.find(id, on: req.db) else {
            throw Abort(.notFound, reason: "Game not found")
        }

        try await game.delete(on: req.db)
        return .noContent
    }

    func getGamePlatforms(req: Request) async throws -> [GamePlatformDTO] {
        let gamePlatformsDB = try await GamePlatform.query(on: req.db).all()
        return gamePlatformsDB.map { gamePlatform in
            GamePlatformDTO(
                id: gamePlatform.id,
                gameId: gamePlatform.$game.id,
                platformId: gamePlatform.$platform.id
            )
        }
    }
    func getGameGenres(req: Request) async throws -> [GamesGenresDTO] {
        let gameGenresDB = try await GameGenre.query(on: req.db).all()
        return gameGenresDB.map { gameGenre in
            GamesGenresDTO(
                id: gameGenre.id,
                gameId: gameGenre.$game.id,
                genreId: gameGenre.$genre.id
            )
        }
    }
}