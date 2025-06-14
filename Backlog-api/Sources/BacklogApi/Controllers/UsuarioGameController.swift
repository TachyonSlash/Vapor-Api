import Vapor
import Fluent

struct UsuarioGameController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let usuarioGames = routes.grouped("usuarioGames")
        usuarioGames.get(use: self.getAll)
        usuarioGames.post(use: self.create)
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
}