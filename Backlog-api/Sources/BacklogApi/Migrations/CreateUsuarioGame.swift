import Fluent

struct CreateUsuarioJuego: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("usuarioGames")
            .id()
            .field("usuario_id", .uuid, .required, .references("usuarios", "id"))
            .field("juego_id", .uuid, .required, .references("games", "id"))
            .field("status", .string, .required)
            .field("review", .string)
            .field("rating", .double)
            .field("fecha_agregado", .datetime)
            .unique(on: "usuario_id", "juego_id")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("usuarioGames").delete()
    }
}