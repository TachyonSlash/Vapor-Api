import NIOSSL
import Fluent
import FluentMySQLDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? " ",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? 3316,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tlsConfiguration: .forClient(certificateVerification:.none)
    ), as: .mysql)

    app.migrations.add(CreateUsuario())
    app.migrations.add(CreateGame())
    app.migrations.add(CreateGenre())
    app.migrations.add(CreatePlatform())
    app.migrations.add(CreateUsuarioJuego())
    app.migrations.add(CreateGamesPlatforms())
    app.migrations.add(CreateGamesGenres())

    app.views.use(.leaf)

    // register routes
    try routes(app)
}
