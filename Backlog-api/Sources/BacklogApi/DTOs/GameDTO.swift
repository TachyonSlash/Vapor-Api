import Vapor
import Foundation

struct GameDTO: Content {
    var id: UUID?
    var title: String
    var desc: String
    var releaseDate: Date
    var developer: String
    var publisher: String
    var platform: [String]
    var genres: [String]
    var image: String?

    init(id: UUID? = nil, title: String, desc: String, releaseDate: Date, developer: String, publisher: String, platform: [String], genres: [String], image: String? = nil) {
        self.id = id
        self.title = title
        self.desc = desc
        self.releaseDate = releaseDate
        self.developer = developer
        self.publisher = publisher
        self.platform = platform
        self.genres = genres
        self.image = image
    }
}