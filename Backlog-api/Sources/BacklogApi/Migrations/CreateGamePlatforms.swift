import Fluent

struct CreateGamesPlatforms: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("gamePlatforms")
            .id()
            .field("gameId", .uuid, .required, references("games", "id", onDelete: .cascade))
            .field("platformId", .uuid, .required, references("platforms", "id", onDelete: .cascade))
            .unique(on: "gameId", "PlatformId")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("gamePlatforms").delete()
    }
}