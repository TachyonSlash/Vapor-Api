import Fluent
import Vapor

final class Game: Model, Content, @unchecked Sendable {
    static let schema = "games"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "desc")
    var desc: String

    @Field(key: "releaseDate")
    var releaseDate: Date

    @Field(key: "developer")
    var developer: String

    @Field(key: "publisher")
    var publisher: String

    @Field(key: "image")
    var image: String

    @Siblings(through: GamePlatform.self, from: \.$game, to: \.$platform)
    var platforms: [Platform]

    @Siblings(through: GameGenre.self, from: \.$game, to: \.$genre)
    var genres: [Genre]

    init() {}
}