import Vapor
import Fluent

struct UsuarioController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let usuarios = routes.grouped("usuarios")
        
        usuarios.get(use: self.getUsuarios)
        usuarios.post(use: self.create)
    }

    func getUsuarios(req: Request) async throws -> [UsuarioDTO] {
        var usuarioMock : [UsuarioDTO] = []
        let usuariosDB = try await Usuario.query(on: req.db).all()
        usuariosDB.forEach { usuario in
            let usuarioDTO = UsuarioDTO(id: usuario.id, username: usuario.username, email: usuario.email, password: usuario.password, image: usuario.image)
            usuarioMock.append(usuarioDTO)
        }
        return usuarioMock
    }   

    func create(req: Request) async throws -> UsuarioDTO {
        let usuarioDTO = try req.content.decode(UsuarioDTO.self)
        let usuario = Usuario()
        usuario.username = usuarioDTO.username
        usuario.email = usuarioDTO.email
        usuario.password = usuarioDTO.password
        usuario.image = usuarioDTO.image
        
        try await usuario.save(on: req.db)
        return usuarioDTO
    }
}