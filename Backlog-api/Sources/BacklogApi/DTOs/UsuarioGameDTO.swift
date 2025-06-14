import Vapor
import Foundation

struct UsuarioGameDTO: Content {
    var id: UUID?
    var usuario_id: UUID
    var juego_id: UUID
    var status: String
    var review: String?
    var rating: Double?
    var fecha_agregado: Date?
}