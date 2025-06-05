import Vapor
import Foundation
import Fluent

struct PlatformController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let platforms = routes.grouped("platforms")

        platforms.get(use: self.getPlatforms)
        platforms.post(use: self.create)
    }

    // Obtiene todas las plataformas
    func getPlatforms(req: Request) async throws -> [PlatformDTO] {
         let platforms = try await Platform.query(on: req.db).all()
         return platforms.map { platform in
            PlatformDTO(id: platform.id, name: platform.name)
        }
    }

    // Crea una nueva plataforma
    func create(req: Request) async throws -> PlatformDTO {
        let dto = try req.content.decode(PlatformDTO.self)

    // Validar que el nombre no es vacío
        guard !dto.name.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw Abort(.badRequest, reason: "Platform name cannot be empty.")
        }

    // Verificar si ya existe una plataforma con el mismo nombre
        if let _ = try await Platform.query(on: req.db)
            .filter(.sql(raw: "LOWER(name) = LOWER(?)"), dto.name)
            .first() {
            throw Abort(.badRequest, reason: "Platform with name '\(dto.name)' already exists.")
        }

        let platform = Platform(name: dto.name)
        try await platform.save(on: req.db)

        return PlatformDTO(id: platform.id, name: platform.name)
    }

}