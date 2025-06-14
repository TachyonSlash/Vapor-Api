import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: UsuarioController())
    try app.register(collection: GameController())
    try app.register(collection: GenreController())
    try app.register(collection: PlatformController())
    try app.register(collection: GamesGenresController())
    try app.register(collection: GamePlatformsController())
    try app.register(collection: UsuarioGameController())
    



}
