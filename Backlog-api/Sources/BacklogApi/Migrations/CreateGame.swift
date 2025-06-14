import Fluent

struct CreateGame: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("games")
            .id()
            .field("title", .string, .required)
            .field("desc", .string, .required)
            // .field("review", .string, .required)
            // .field("rating", .double, .required)
            .field("releaseDate", .datetime, .required)
            .field("developer", .string, .required)
            .field("publisher", .string, .required)
            .field("platform", .json, .required)
            .field("genres", .json, .required)
            .field("image", .custom("VARCHAR(500)"))
            .unique(on: "title")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("games").delete()
    }
}