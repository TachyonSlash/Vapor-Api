import Vapor
import Fluent

struct GenreController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let genres = routes.grouped("genres")
        genres.get(use: self.getGenres)
        genres.post(use: self.create)
    }

    func getGenres(req: Request) async throws -> [GenreDTO] {
        let genresDB = try await Genre.query(on: req.db).all()
        return genresDB.map { genre in
            GenreDTO(id: genre.id, name: genre.name)
        }
    }

    func create(req: Request) async throws -> GenreDTO {
        let genreDTO = try req.content.decode(GenreDTO.self)
        let genre = Genre()
        genre.name = genreDTO.name
        try await genre.save(on: req.db)
        return genreDTO
    }
}