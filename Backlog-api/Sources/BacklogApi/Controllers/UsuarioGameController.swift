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
            var usuarioGameDTO = UsuarioGameDTO(
                id: usuarioGame.id,
                usuario_id: usuarioGame.usuario_id,
                juego_id: usuarioGame.juego_id,
                status: usuarioGame.status,
                review: usuarioGame.review,
                rating: usuarioGame.rating,
                fecha_agregado: usuarioGame.fecha_agregado
            )
            usuarioGamesMock.append(usuarioGameDTO)
        }
        return usuarioGamesMock
    }

    func create(req: Request) async throws -> UsuarioGameDTO {
        let usuarioGameDTO = try req.content.decode(UsuarioGameDTO.self)
        let usuarioGame = UsuarioGame(
            id: usuarioGameDTO.id,
            usuario_id: usuarioGameDTO.usuario_id,
            juego_id: usuarioGameDTO.juego_id,
            status: usuarioGameDTO.status,
            review: usuarioGameDTO.review,
            rating: usuarioGameDTO.rating,
            fecha_agregado: usuarioGameDTO.fecha_agregado
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
        
        usuarioGame.usuario_id = usuarioGameDTO.usuario_id
        usuarioGame.juego_id = usuarioGameDTO.juego_id
        usuarioGame.status = usuarioGameDTO.status
        usuarioGame.review = usuarioGameDTO.review
        usuarioGame.rating = usuarioGameDTO.rating
        usuarioGame.fecha_agregado = usuarioGameDTO.fecha_agregado
        
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