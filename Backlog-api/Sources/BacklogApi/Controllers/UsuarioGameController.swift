import Vapor
import Fluent

struct UsuarioGameController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let usuarioGames = routes.grouped("usuarioGames")
        usuarioGames.get(use: self.getAll)
        usuarioGames.post(use: self.create)
        usuarioGames.put(use: self.update)
        usuarioGames.delete(":id", use: self.delete)
    }

     func getAll(req: Request) async throws -> [UsuarioGameDTO] {
        var usuarioGamesMock: [UsuarioGameDTO] = []
        let usuarioGamesDB = try await UsuarioGame.query(on: req.db).all()
        usuarioGamesDB.forEach { usuarioGame in
            let usuarioGameDTO = UsuarioGameDTO(
                id: usuarioGame.id,
                usuarioId: usuarioGame.$usuario.id,
                juegoId: usuarioGame.$game.id,
                status: usuarioGame.status,
                review: usuarioGame.review,
                rating: usuarioGame.rating,
                fechaAgregado: usuarioGame.fechaAgregado
            )
            usuarioGamesMock.append(usuarioGameDTO)
        }
        return usuarioGamesMock
    }

    func create(req: Request) async throws -> UsuarioGameDTO {
        let usuarioGameDTO = try req.content.decode(UsuarioGameDTO.self)
        let usuarioGame = UsuarioGame(
            id: usuarioGameDTO.id,
            usuarioId: usuarioGameDTO.usuarioId,
            juegoId: usuarioGameDTO.juegoId,
            status: usuarioGameDTO.status,
            review: usuarioGameDTO.review,
            rating: usuarioGameDTO.rating,
            fechaAgregado: usuarioGameDTO.fechaAgregado
        )
        try await usuarioGame.save(on: req.db)
        return usuarioGameDTO
    }

    func update(req: Request) async throws -> UsuarioGameDTO {
        let usuarioGameDTO = try req.content.decode(UsuarioGameDTO.self)
        guard let id = usuarioGameDTO.id else {
            throw Abort(.badRequest, reason: "ID is required for update")
        }
        
        guard let usuarioGame = try await UsuarioGame.find(id, on: req.db) else {
            throw Abort(.notFound, reason: "UsuarioGame not found")
        }
        
        usuarioGame.$usuario.id = usuarioGameDTO.usuarioId
        usuarioGame.$game.id = usuarioGameDTO.juegoId
        usuarioGame.status = usuarioGameDTO.status
        usuarioGame.review = usuarioGameDTO.review
        usuarioGame.rating = usuarioGameDTO.rating
        usuarioGame.fechaAgregado = usuarioGameDTO.fechaAgregado
        
        try await usuarioGame.update(on: req.db)
        return usuarioGameDTO
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest, reason: "ID is required for deletion")
        }
        
        guard let usuarioGame = try await UsuarioGame.find(id, on: req.db) else {
            throw Abort(.notFound, reason: "UsuarioGame not found")
        }
        
        try await usuarioGame.delete(on: req.db)
        return .noContent
    }
}