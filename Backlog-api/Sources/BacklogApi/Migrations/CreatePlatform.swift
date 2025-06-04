import Fluent

struct CreatePlatform: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("platforms")
            .id()
            .field("name", .string, .required)
            .unique(on: "name")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("platforms").delete()
    }
}