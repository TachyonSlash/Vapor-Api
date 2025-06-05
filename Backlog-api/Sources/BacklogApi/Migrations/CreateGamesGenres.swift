import Fluent

struct CreateGamesGenres: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("gameGenres")
            .id()
            .field("gameId", .uuid, .required, references("games", "id", onDelete: .cascade))
            .field("genreId", .uuid, .required, references("genres", "id", onDelete: .cascade))
            .unique(on: "gameId", "GenreId")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("gameGenres").delete()
    }
}