import Fluent

struct CreateUsuario: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("usuarios")
            .id()
            .field("username", .string, .required)
            .field("email", .string, .required)
            .field("password", .string, .required)
            .field("image", .custom("VARCHAR(500)"))
            .unique(on: "email", "username")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("usuarios").delete()
    }
}